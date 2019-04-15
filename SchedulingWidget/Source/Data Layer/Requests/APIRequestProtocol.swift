//
//  APIRequestProtocol.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

public protocol APIRequest {
    
    var baseURLString: String           { get }
    var endpoint: String                { get }
    var method: HTTPMethod              { get }
    var parameters: [String: String]    { get }
    var headers: [String: String]       { get }
    
}

public extension APIRequest {
    
    var genericParameters: [String: String] {
        return ["Accept": "application/vnd.api+json"]
        
    }
    
    var headers: [String: String] {
        return [
            "api-version": "1",
            "application-platform": "1",
            "application-build-version": "1"
        ]
        
    }
    
    func urlRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: try url())
        
        urlRequest.httpMethod = method.rawValue
        
        headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return urlRequest
        
    }
    
    func url() throws -> URL {
        
        var urlString = baseURLString
        
        if !endpoint.isEmpty {
            urlString += "/" + endpoint
        }
        
        if let query = query {
            urlString += "?" + query
        }
        
        guard let url = URL(string: urlString) else { throw APIClientError.badURL }
        
        return url
        
    }
    
    private var query: String? {
        
        let params = genericParameters.compactMap({ "\($0)=\($1)" }) + parameters.compactMap({ "filter[\($0)]=\($1)" })
        
        return params.joined(separator: "&")
        
    }
    
}
