//
//  Date + Extension.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import Foundation

extension Date {
    func get(component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    func toYearMonthDay() -> YearMonthDay {
        return .init(
            year: self.get(component: .year),
            month: self.get(component: .month),
            day: self.get(component: .day)
        )
    }
}
