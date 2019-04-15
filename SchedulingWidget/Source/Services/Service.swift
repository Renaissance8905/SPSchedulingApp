//
//  Service.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

struct ServiceResponse: Response {
    typealias DataType = Service
    
    var data: [DataType]
    var links: PaginationLinks
    
}

struct Service: APIData, SchedulingData {
    
    typealias AttributeType = ServiceAttributes
    
    var id: String
    var type: String
    var attributes: ServiceAttributes
    
    struct ServiceAttributes: Attributes {
        
        var description: String
        var duration: Int
        var rate: String
        private var callToBook: String
        
        var offersCallToBook: Bool {
            return callToBook.lowercased() == "true"
        }
        
    }
    
    var textRepresentation: [String] {
        return [attributes.description, "\(attributes.duration) minutes"]
    }
    
}
