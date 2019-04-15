//
//  Request.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

enum Request: APIRequest {
    
    case services(Clinician)
    case locations(Clinician, Service)
    
    var method: HTTPMethod { return .GET }
    
    var baseURLString: String {
        switch self {
        case .services(let clinician),
             .locations(let clinician, _):
            return clinician.url
        }    }
    
    var endpoint: String {
        switch self {
        case .services:  return "client-portal-api/cpt-codes"
        case .locations: return "client-portal-api/offices"
        }
        
    }
    
    var parameters: [String: String] {
        switch self {
        case .services(let clinician):
            return ["clinicianId": clinician.id]
        case .locations(let clinician, let service):
            return ["clinicianId": clinician.id, "cptCodeId": service.id]
        }
        
    }
    
    
}

