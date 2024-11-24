//
//  Errors.swift
//  Idealista
//
//  Created by Conrado Capilla García on 24/11/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case errorFetchingData
    case errorParsingData
}
