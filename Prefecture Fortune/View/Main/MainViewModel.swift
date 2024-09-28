//
//  MainViewModel.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class MainViewModel {
    // MARK: Inputs
    var name: String = ""
    var birthday: Date = .createDate(year: 2000, month: 1, day: 1)!
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
        if name.isEmpty {
            alertType = .emptyData
            return
        }
        
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
    
    func resetInputs() {
        name = ""
        birthday = .createDate(year: 2000, month: 1, day: 1)!
    }
    
    func saveHistory(context: ModelContext) {
        guard let fortuneResult else { return }
        
        let newData = FortuneData(
            request: .init(
                name: name,
                birthday: birthday.toYearMonthDay(),
                bloodType: bloodType,
                today: .today()
            ),
            response: fortuneResult,
            date: .now
        )
        
        context.insert(newData)
    }
}
