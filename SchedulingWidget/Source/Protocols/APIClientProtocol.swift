//
//  APIClientProtocol.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

public protocol APIClient {
    func sendRequest<T: Codable>(_ request: APIRequest, completion: @escaping ResultCompletion<T>)
}
