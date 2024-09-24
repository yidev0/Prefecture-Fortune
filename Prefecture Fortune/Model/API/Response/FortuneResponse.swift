//
//  FortuneResponse.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

struct FortuneResponse: Codable {
    let name: String
    let capital: String
    let citizenDay: MonthDay?
    let hasCoastLine: Bool
    let logoUrl: String
    let brief: String
}

struct MonthDay: Codable {
    let month: Int
    let day: Int
}
