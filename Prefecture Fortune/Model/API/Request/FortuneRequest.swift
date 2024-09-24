//
//  FortuneRequest.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

struct YearMonthDay: Codable {
    let year: Int
    let month: Int
    let day: Int
}

struct FortuneRequest: Codable {
    let name: String
    let birthday: YearMonthDay
    let bloodType: String
    let today: YearMonthDay
}
