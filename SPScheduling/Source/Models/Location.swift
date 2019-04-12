//
//  Location.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

struct LocationResponse: Response {    
    typealias DataType = Location
    
    var data: [Location]
    var links: PaginationLinks
    
}

struct Location: APIData {
    
    typealias AttributeType = LocationAttributes
    
    var id: String
    var type: String
    var attributes: LocationAttributes
    
    struct LocationAttributes: Attributes {
        var city: String
        var name: String
        var state: String
        var street: String
        var zip: String
        var phone: String
        var isVideo: Bool
        
    }
    
}
