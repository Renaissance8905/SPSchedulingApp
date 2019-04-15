//
//  SchedulingWidgetProtocol.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

public typealias AppointmentReturn = ((Appointment) -> Void)?

public protocol SchedulingWidgetProtocol {
    
    static func launchWithClinician(_ clinician: Clinician?, apiClient: APIClient, presenter: UIViewController, result: AppointmentReturn)

}

public extension SchedulingWidgetProtocol {
    
    static func launch(apiClient: APIClient, presenter: UIViewController, result: AppointmentReturn) {
        launchWithClinician(nil, apiClient: apiClient, presenter: presenter, result: result)
    }
    
    static func launch(presenter: UIViewController, result: AppointmentReturn) {
        launch(apiClient: SchedulingAPIClient(), presenter: presenter, result: result)
    }
    
    static func launchWithClinician(_ clinician: Clinician?, presenter: UIViewController, result: AppointmentReturn) {
        launchWithClinician(clinician, apiClient: SchedulingAPIClient(), presenter: presenter, result: result)
    }

}
