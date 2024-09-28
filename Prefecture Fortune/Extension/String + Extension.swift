//
//  String + Extension.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/28.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
