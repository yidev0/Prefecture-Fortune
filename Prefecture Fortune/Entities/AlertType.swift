//
//  AlertType.swift
//  Prefecture Fortune
//
//  Created by Yuto on 2024/09/25.
//

import SwiftUI

enum AlertType: LocalizedError {
    case invalidData
    case networkError
    case serverError
    case undefined(statusCode: Int)
}

extension AlertType {
    var errorDescription: String? {
        switch self {
        case .invalidData:
            "Alert.Title.InvalidData".localized
        case .networkError:
            "Alert.Title.NetworkError".localized
        case .serverError:
            "Alert.Title.ServerError".localized
        case .undefined(let statusCode):
            "Alert.Title.Undefined(\(statusCode))".localized
        }
    }
}
