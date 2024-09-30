//
//  FortuneData.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import SwiftData
import Foundation

@Model
final class FortuneData {
    var name: String
    var birthday: YearMonthDay
    var bloodType: BloodType
    
    var prefectureName: String
    var capital: String
    var citizenDay: MonthDay?
    var hasCoastLine: Bool
    var logoUrl: String
    var brief: String
    
    var date: Date
    
    init(
        request: FortuneRequest,
        response: FortuneResponse,
        date: Date
    ) {
        self.name = request.name
        self.birthday = request.birthday
        self.bloodType = request.bloodType

        self.prefectureName = response.name
        self.capital = response.capital
        self.citizenDay = response.citizenDay
        self.hasCoastLine = response.hasCoastLine
        self.logoUrl = response.logoUrl
        self.brief = response.brief
        
        self.date = date
    }
}

extension FortuneData {
    static let sample = FortuneData(
        request: .sample,
        response: .sample,
        date: .now
    )
}
