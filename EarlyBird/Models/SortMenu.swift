//
//  SortOption.swift
//  EarlyBird
//
//  Created by Eunji Hwang on 24/12/2023.
//

import Foundation

struct SortOptionItem {
    var menu: SortOption
    var hasOrder: Bool
    var ascend: String {
        return menu.ascend
    }
    var descend: String {
        return menu.descend
    }
}


enum Car: CaseIterable {
    static var allCases: [Car] {
        return [.ford, .toyota, .jaguar, .bmw, .porsche(convertible: false), .porsche(convertible: true)]
    }

    case ford, toyota, jaguar, bmw
    case porsche(convertible: Bool)
}


enum SortOrder: String {
    case ascend
    case descend
}


enum SortOption: String, CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }

    case manual = "Manual"
    case title = "Title"
    case active = "Active"
    case duration = "Duration"
 
    var ascend: String {
        switch self {
        case .manual:
            return ""
        case .active:
            return "Active first"
        case .title:
            return "Ascending"
        case .duration:
            return "Shortest First"
        }
    }

    var descend: String {
        switch self {
        case .manual:
            return ""
        case .active:
            return "Inactive First"
        case .title:
            return "Descending"
        case .duration:
            return "Longest First"
        }
    }
    var hasOrder: Bool {
        switch self {
        case .manual:
            return false
        default:
            return true
        }
    }
    static var allCases: [SortOption] {
        return [.manual, .active, .title, .duration]
    }
}

