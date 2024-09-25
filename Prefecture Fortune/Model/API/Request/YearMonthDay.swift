//
//  YearMonthDay.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import Foundation

struct YearMonthDay: Codable {
    let year: Int
    let month: Int
    let day: Int
}

extension YearMonthDay {
    static func today() -> Self {
        return .make(from: Date.now)
    }
    
    static func make(from date: Date) -> Self {
        return .init(
            year: date.get(component: .year),
            month: date.get(component: .month),
            day: date.get(component: .day)
        )
    }
}
