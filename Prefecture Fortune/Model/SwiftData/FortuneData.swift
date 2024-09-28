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
    var request: FortuneRequest
    var response: FortuneResponse
    var date: Date
    
    init(
        request: FortuneRequest,
        response: FortuneResponse,
        date: Date
    ) {
        self.request = request
        self.response = response
        self.date = date
    }
}
