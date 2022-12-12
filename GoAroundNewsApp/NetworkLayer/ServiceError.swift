//
//  ServiceError.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 09/12/22.
//

import Foundation

enum ServiceError: Error {
    case serverError(error: Error? = nil, message: String = "")
}

extension ServiceError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .serverError(let error, let message):
            return error?.localizedDescription ?? message
        }
    }
    
}
