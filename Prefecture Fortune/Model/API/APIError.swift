//
//  APIError.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

enum APIClientError: Error {
    case invalidResponse
    case invalidData
    case invalidURL
    case networkError
    case serverError
    case undefined(statusCode: Int)
}
