//
//  APIClient.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/24.
//

import Foundation

struct FortuneAPIClient {
    
    let baseURL = URL(string: "https://ios-junior-engineer-codecheck.yumemi.jp")!
    
    func fetchResponse(reqeust: FortuneRequest) async -> Result<FortuneResponse?, APIClientError> {
        let component = URLComponents(
            url: baseURL.appending(path: "/my_fortune"),
            resolvingAgainstBaseURL: true
        )
        
        let requestBody = reqeust
        
        guard let url = component?.url else {
            return .failure(.invalidURL)
        }
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "API-Version": "v1",
            "Content-Type": "application/json"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpURLResponse = response as? HTTPURLResponse else {
                preconditionFailure()
            }
            
            print(httpURLResponse.statusCode)
            do {
                let loginResponse = try JSONDecoder().decode(FortuneResponse.self, from: data)
                return .success(loginResponse)
            } catch {
                return .failure(.invalidResponse)
            }
        } catch {
            return .failure(.invalidData)
        }
    }
    
}
