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
    var isFetching = false
    var fortuneResult: FortuneResponse?
    
    var alertType: AlertType? {
        didSet {
            showAlert = alertType != nil
        }
    }
    var showAlert = false
    
    init() {}
    
    func fetchFortune() {
        Task {
            isFetching = true
            let fortuneResponse = await FortuneAPIClient().fetchResponse(
                reqeust: .init(
                    name: name,
                    birthday: birthday.toYearMonthDay(),
                    bloodType: bloodType,
                    today: .today()
                )
            )
            
            isFetching = false
            
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
                case .networkError:
                    alertType = .networkError
                case .serverError:
                    alertType = .serverError
                case .undefined(statusCode: let statusCode):
                    alertType = .undefined(statusCode: statusCode)
                }
            }
        }
    }
}
