//
//  APIResponseProtocols.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

protocol Response: Codable {
    associatedtype DataType: APIData
    
    var data: [DataType]        { get set }
    var links: PaginationLinks  { get set }
    
}

struct PaginationLinks: Codable {
    var first: String
    var last: String
    
}

protocol APIData: Codable {
    associatedtype AttributeType: Attributes
    
    var id: String                  { get set }
    var type: String                { get set }
    var attributes: AttributeType   { get set }
    
}

protocol Attributes: Codable {}
