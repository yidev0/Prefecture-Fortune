//
//  MonthDay.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import Foundation

struct MonthDay: Codable {
    let month: Int
    let day: Int
}

extension MonthDay {
    var dateString: String {
        if let locale = Locale.current.language.languageCode?.identifier, locale == "ja" {
            return "\(month)月\(day)日"
        } else {
            let monthSymbols = Calendar.current.monthSymbols
            if (month - 1) < monthSymbols.count {
                return monthSymbols[month - 1] + " \(day)"
            }
        }
        
        return "\(month)/\(day)"
    }
}
