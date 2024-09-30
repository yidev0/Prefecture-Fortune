//
//  TellFortuneIntent.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/10/01.
//

import AppIntents

struct TellFortuneIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Label.TellFortune"
    
    @Parameter
    var name: String
    
    @Parameter()
    var birthday: Date
    
    @Parameter
    var bloodType: BloodTypeEntity
    
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        if name.isEmpty {
            throw AlertType.emptyData
        }
        
        let fortuneResponse = await FortuneAPIClient().fetchResponse(
            reqeust: .init(
                name: name,
                birthday: birthday.toYearMonthDay(),
                bloodType: .init(rawValue: bloodType.id) ?? .a,
                today: .today()
            )
        )
        
        switch fortuneResponse {
        case .success(let success):
            return .result(value: success.name)
        case .failure(let failure):
            switch failure {
            case .invalidResponse, .invalidData, .invalidURL:
                throw AlertType.invalidData
            case .networkError:
                throw AlertType.networkError
            case .serverError:
                throw AlertType.serverError
            case .undefined(statusCode: let statusCode):
                throw AlertType.undefined(statusCode: statusCode)
            }
        }
    }
    
}
