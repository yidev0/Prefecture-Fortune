//
//  TellFortuneIntent.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/10/01.
//

import AppIntents
import SwiftData

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
            await saveFortune(result: success)
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
    
    @MainActor
    private func saveFortune(result: FortuneResponse) {
        let sharedModelContainer: ModelContainer = {
            let schema = Schema([FortuneData.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        
        let fortuneData = FortuneData(
            request: .init(
                name: name,
                birthday: .make(from: birthday),
                bloodType: .init(rawValue: bloodType.id)!,
                today: .today()
            ),
            response: result,
            date: .now
        )
        
        let context = sharedModelContainer.mainContext
        context.insert(fortuneData)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
}
