//
//  LazyList.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/1/2024.
//

import Foundation

/**
 제네릭 T 타입을 가진 LazyList 구조체이다.
 */
struct LazyList<T> {

    // index 입력을 받아서, T타입의 값을 반환하거나, 오류를 던질 수 있는 함수
    typealias Access = (Int) throws -> T?
    
    // 실제 요소에 접근할 때 사용할 함수
    private let access: Access
    
    // 이 값이 true이면, 리스트는 요소에 접근할 때 캐싱을 사용한다.
    // 가지고 있으면 그걸 보여주고, 안가지고 있으면 가져와서 보여준다는 것.
    private let useCache: Bool
    
    // 아래에 정의되어 있음.
    private var cache = Cache()
    
    let count: Int
    
    init(count: Int, useCache: Bool, _ access: @escaping Access) {
        self.count = count
        self.useCache = useCache
        self.access = access
    }
    
    func element(at index: Int) throws -> T {
        guard useCache else {
            return try get(at: index)
        }
        return try cache.sync { elements in
            if let element = elements[index] {
                return element
            }
            let element = try get(at: index)
            elements[index] = element
            return element
        }
    }
    
    private func get(at index: Int) throws -> T {
        guard let element = try access(index) else {
            throw Error.elementIsNil(index: index)
        }
        return element
    }
    
    static var empty: Self {
        return .init(count: 0, useCache: false) { index in
            throw Error.elementIsNil(index: index)
        }
    }
}

// MARK: - 캐시 클래스
private extension LazyList {
    class Cache {
        // 인덱스를 키로 하고, T타입의 요소를 값으로 하는 딕셔너리 형태
        // 딕셔너리는 값을 검색하는데 최적화 되어 있음
        private var elements = [Int: T]()
        // 캐시에 안전하게 접근하게 하기 위해서,
        // 메인 쓰레드에서만 캐시에 접근하거나 변경한다.
        func sync(_ access: (inout [Int: T]) throws -> T) throws -> T {
            guard Thread.isMainThread else {
                var result: T!
                try DispatchQueue.main.sync {
                    result = try access(&elements)
                }
                return result
            }
            return try access(&elements)
        }
    }
}


// 일반 컬렉션처럼 동작하게 하기 위해서
extension LazyList: Sequence {
    
    enum Error: LocalizedError {
        case elementIsNil(index: Int)
        
        var localizedDescription: String {
            switch self {
            case let .elementIsNil(index):
                return "Element at index \(index) is nil"
            }
        }
    }
    
    struct Iterator: IteratorProtocol {
        typealias Element = T
        private var index = -1
        private var list: LazyList<Element>
        
        init(list: LazyList<Element>) {
            self.list = list
        }
        
        mutating func next() -> Element? {
            index += 1
            guard index < list.count else {
                return nil
            }
            do {
                return try list.element(at: index)
            } catch _ {
                return nil
            }
        }
    }

    func makeIterator() -> Iterator {
        .init(list: self)
    }

    var underestimatedCount: Int { count }
}

// 일반 컬렉션처럼 동작하게 하기 위해서
extension LazyList: RandomAccessCollection {
    
    typealias Index = Int
    var startIndex: Index { 0 }
    var endIndex: Index { count }
    
    subscript(index: Index) -> Iterator.Element {
        do {
            return try element(at: index)
        } catch let error {
            fatalError("\(error)")
        }
    }

    public func index(after index: Index) -> Index {
        return index + 1
    }

    public func index(before index: Index) -> Index {
        return index - 1
    }
}

// LazyList의 요소 자체가 Equatable 해야지, LazyList 자체도 Equatable을 준수할 수 있다.
// 두 연산자는 각 인스턴스가 동일한지 비교한다.
extension LazyList: Equatable where T: Equatable {
    static func == (lhs: LazyList<T>, rhs: LazyList<T>) -> Bool {
        // 동일성검사 : 두 리스트의 요소 수가 같은지를 우선 확인 (다르면 다른 객체이므로)
        guard lhs.count == rhs.count else { return false }
        // 두 리스트의 요소를 짝지어 비교한다.
        // 하나라도 다른 짝이 발견되면 false를 리턴한다.
        return zip(lhs, rhs).first(where: { $0 != $1 }) == nil
    }
}

extension LazyList: CustomStringConvertible {
    var description: String {
        let elements = self.reduce("", { str, element in
            if str.count == 0 {
                return "\(element)"
            }
            return str + ", \(element)"
        })
        return "LazyList<[\(elements)]>"
    }
}

extension RandomAccessCollection {
    var lazyList: LazyList<Element> {
        return .init(count: self.count, useCache: false) {
            guard $0 < self.count else { return nil }
            let index = self.index(self.startIndex, offsetBy: $0)
            return self[index]
        }
    }
}
