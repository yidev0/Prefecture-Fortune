//
//  HistoryViewModel.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/30.
//

import Foundation

@Observable
class HistoryViewModel {
    
    var sectionaizedData = [Date: [FortuneData]]()
    var fortuneResult: FortuneResponse?
    
    func showSheet(for data: FortuneData) {
        fortuneResult = .init(
            name: data.prefectureName,
            capital: data.capital,
            citizenDay: data.citizenDay,
            hasCoastLine: data.hasCoastLine,
            logoUrl: data.logoUrl,
            brief: data.brief
        )
    }
    
    func sectionzeData(data: [FortuneData]) {
        sectionaizedData = Dictionary(
            grouping: data
        ) { item in
            formatDate(item.date)
        }
    }
    
    func formatDate(_ date: Date) -> Date {
        return .createDate(
            year: date.get(component: .year),
            month: date.get(component: .month),
            day: date.get(component: .day)
        )!
    }
}
