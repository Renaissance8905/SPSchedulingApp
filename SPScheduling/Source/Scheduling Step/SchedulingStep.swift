//
//  SchedulingStep.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

enum SchedulingStep: Int, CaseIterable {
    case clinician = 1
    case service
    case location
    case dateTime
    case info
    
    init?(for indexPath: IndexPath) {
        self.init(rawValue: indexPath.row + 1)
    }
    
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
    
    func viewController(_ widget: SchedulingWidget) -> (SchedulingViewController & UIViewController) {
        switch self {
        case .clinician:    return ClinicianViewController.viewController(with: widget)
        case .service:      return ServicesCollectionViewController.viewController(with: widget)
        case .location:     return LocationsCollectionViewController.viewController(with: widget)
        case .dateTime:     return DateTimeViewController.viewController(with: widget)
        case .info:         return YourInfoViewController.viewController(with: widget)
        }
    }
    
    var next: SchedulingStep {
        return SchedulingStep(rawValue: index + 1) ?? self
        
    }
    
    var previous: SchedulingStep {
        return SchedulingStep(rawValue: index - 1) ?? self
        
    }
    
}
