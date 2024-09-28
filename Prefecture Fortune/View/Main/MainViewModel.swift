//
//  MainViewModel.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import Foundation
import SwiftUI

@Observable
class MainViewModel {
    // MARK: Inputs
    var name: String = ""
    var birthday: Date = .now
    var bloodType: BloodType = .a
    
    // MARK: Outputs
    var fortuneResult: FortuneResponse?
    var alertType: AlertType?
    
    init() {}
    
    func fetchFortune() async {
        let fortuneResponse = await FortuneAPIClient().fetchResponse(
            reqeust: .init(
                name: name,
                birthday: birthday.toYearMonthDay(),
                bloodType: bloodType,
                today: .today()
            )
        )
        
        switch fortuneResponse {
        case .success(let success):
            fortuneResult = success
        case .failure(let failure):
            switch failure {
            case .invalidResponse:
                alertType = .invalidData
            case .invalidData:
                alertType = .invalidData
            case .invalidURL:
                alertType = .invalidData
            }
        }
    }
}
