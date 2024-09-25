//
//  FortuneRequest.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import Foundation

struct FortuneRequest: Codable {
    let name: String
    let birthday: YearMonthDay
    let bloodType: BloodType
    let today: YearMonthDay
}

extension FortuneRequest {
    static let sample: Self = .init(
        name: "ゆめみん",
        birthday: .init(
            year: 2000,
            month: 1,
            day: 27
        ),
        bloodType: .ab,
        today: .init(
            year: 2023,
            month: 5,
            day: 5
        )
    )
}
