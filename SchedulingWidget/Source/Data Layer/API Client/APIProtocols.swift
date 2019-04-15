//
//  APIProtocols.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

public typealias ResultCompletion<T> = (Result<T>) -> Void

public enum Result<T> {
    case success(T)
    case requestFailure(APIClientError?)
    case responseFailure(ResponseError?)
}

public enum APIClientError: Error {
    case missingInputData
    case badURL
}

public enum ResponseError: Error {
    case parsingError(DecodingError?)
    case apiError(Error)
    case noData
}
