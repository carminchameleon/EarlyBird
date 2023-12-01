//
//  ExtensionString.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 25/11/2023.
//

import Foundation

extension String {
    
    func convertToTimeInterval(_ sting: String) -> TimeInterval? {
        var timeInterval: TimeInterval = 0

        // "HR", "MIN", "SEC"을 제거하고 문자열을 분리
        let components = sting.components(separatedBy: " ")

        for component in components {
            // 각 부분에서 숫자를 추출
            if let value = Int(component), value > 0 {
                // 시간 단위 처리
                if component.contains(Time.hours.rawValue) {
                    timeInterval += TimeInterval(value * 3600)
                }
                // 분 단위 처리
                else if component.contains(Time.minutes.rawValue) {
                    timeInterval += TimeInterval(value * 60)
                }
                // 초 단위 처리
                else if component.contains(Time.seconds.rawValue) {
                    timeInterval += TimeInterval(value)
                }
                // 단위 없이 숫자만 있는 경우 초로 간주
                else {
                    timeInterval += TimeInterval(value)
                }
            }
        }

        return timeInterval
    }

}


struct Common {
    
    func convertToTimeInterval(_ sting: String) -> TimeInterval? {
        var timeInterval: TimeInterval = 0

        // "HR", "MIN", "SEC"을 제거하고 문자열을 분리
        let components = sting.components(separatedBy: " ")

        for component in components {
            // 각 부분에서 숫자를 추출
            if let value = Int(component), value > 0 {
                // 시간 단위 처리
                if component.contains(Time.hours.rawValue) {
                    timeInterval += TimeInterval(value * 3600)
                }
                // 분 단위 처리
                else if component.contains(Time.minutes.rawValue) {
                    timeInterval += TimeInterval(value * 60)
                }
                // 초 단위 처리
                else if component.contains(Time.seconds.rawValue) {
                    timeInterval += TimeInterval(value)
                }
                // 단위 없이 숫자만 있는 경우 초로 간주
                else {
                    timeInterval += TimeInterval(value)
                }
            }
        }

        return timeInterval
    }
}
