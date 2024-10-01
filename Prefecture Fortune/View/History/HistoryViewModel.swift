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
        sectionaizedData = FortuneDataOrganizer().sectionze(data: data)
    }
}
