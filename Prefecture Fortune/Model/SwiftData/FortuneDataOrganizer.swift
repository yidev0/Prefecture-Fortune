//
//  FortuneDataOrganizer.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/30.
//

import Foundation

struct FortuneDataOrganizer {
    func sectionze(data: [FortuneData]) -> [Date: [FortuneData]] {
        return Dictionary(
            grouping: data
        ) { item in
            formatDate(item.date)
        }
    }
    
    private func formatDate(_ date: Date) -> Date {
        return .createDate(
            year: date.get(component: .year),
            month: date.get(component: .month),
            day: date.get(component: .day)
        )!
    }
}
