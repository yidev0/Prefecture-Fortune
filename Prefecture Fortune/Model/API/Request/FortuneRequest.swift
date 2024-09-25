//
//  FortuneRequest.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import Foundation

struct YearMonthDay: Codable {
    let year: Int
    let month: Int
    let day: Int
}

struct FortuneRequest: Codable {
    let name: String
    let birthday: YearMonthDay
    let bloodType: String
    let bloodType: BloodType
    let today: YearMonthDay
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

extension FortuneRequest {
    static let sample: Self = .init(
        name: "ゆめみん",
        birthday: .init(
            year: 2000,
            month: 1,
            day: 27
        ),
        bloodType: "ab",
        bloodType: .ab,
        today: .init(
            year: 2023,
            month: 5,
            day: 5
        )
    )
        
}
