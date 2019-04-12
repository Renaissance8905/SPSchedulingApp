//
//  SchedulingStep.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

enum SchedulingStep: Int, CaseIterable {
    case clinician = 1
    case service
    case location
    case dateTime
    case info
    
    var index: Int {
        return rawValue
    }
    
    var title: String {
        switch self {
        case .clinician:    return "CLINICIAN"
        case .service:      return "SERVICE"
        case .location:     return "SELECT A LOCATION"
        case .dateTime:     return "SELECT DATE & TIME"
        case .info:         return "YOUR INFORMATION"
        }
    }
    
}
