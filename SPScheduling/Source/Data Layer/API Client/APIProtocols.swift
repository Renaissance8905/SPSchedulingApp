//
//  APIProtocols.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

typealias ResultCompletion<T> = (Result<T>) -> Void

enum Result<T> {
    case success(T)
    case requestFailure(APIClientError?)
    case responseFailure(ResponseError?)
}

enum APIClientError: Error {
    case missingInputData
    case badURL
}

enum ResponseError: Error {
    case parsingError(DecodingError?)
    case apiError(Error)
    case noData
}
