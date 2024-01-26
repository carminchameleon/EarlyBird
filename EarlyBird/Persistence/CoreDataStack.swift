//
//  CoreDataStack.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/1/2024.
//


import Combine
import CoreData

protocol PersistenceStore {
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result

    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>, map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error>
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
}

struct CoreDataStack: PersistenceStore {
    
    private let container: NSPersistentContainer
    private let isStoreLoaded = CurrentValueSubject<Bool, Error>(false)

    // 데이터 업데이트에 관한 작업을 다 background에서 작업하기 위한 것
    // 커스텀 디스패치 큐이기 때문에 우선 병렬 serial로 작동할 것임. (순서대로 작동한다는 의미)
    private let bgQueue = DispatchQueue(label: "coredata")
    
    init() {
        container = NSPersistentContainer(name: "EarlyBird")
        bgQueue.async {[weak isStoreLoaded, weak container] in
            container?.loadPersistentStores(completionHandler: { (storeDescription, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        isStoreLoaded?.send(completion: .failure(error))
                    } else {
                        isStoreLoaded?.value = true
                    }
                }

            })
            
        }
    }
    // isStoreLoaded 값이 변경되었을 때
    // filt
    private var onStoreIsReady: AnyPublisher<Void, Error> {
        return isStoreLoaded // 이 값이 변경되었을 때
            .filter { $0 } // 이 값이 true라면
            .map { _ in } // Void를 반환
            .eraseToAnyPublisher() // 퍼블리셔의 구체적인 타입을 숨기고 AnyPublisher로 반환
    }
    
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<[V], Error> {
       
        assert(Thread.isMainThread)
        let fetch = Future<[V], Error> {[weak container] promise in
            guard let context = container?.viewContext else { return }
            context.performAndWait {
                do {
                    let result = try context.fetch(fetchRequest)
                    let mappedResults = try result.compactMap(map)
                    promise(.success(mappedResults))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        return onStoreIsReady
            .flatMap { fetch }
            .eraseToAnyPublisher()
    }
    
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error> {
        let update = Future<Result, Error> { [weak bgQueue, weak container] promise in
            bgQueue?.async {
                guard let context = container?.newBackgroundContext() else { return }
                context.performAndWait {
                    do {
                        // update 함수
                        let result = try operation(context)
                        if context.hasChanges {
                            try context.save()
                        }
                        context.reset()
                        promise(.success(result))
                    } catch {
                        context.reset()
                        promise(.failure(error))
                    }
                }
            }
        }
        return onStoreIsReady
            .flatMap { update }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
