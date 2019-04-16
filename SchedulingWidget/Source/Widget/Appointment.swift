//
//  Appointment.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/15/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

public struct Appointment {
    var clinician: Clinician
    var service: Service
    var location: Location
    var apptTime: AppointmentTime
    var clientInfo: ClientInfo
    
    public var clientName: String {
        return clientInfo.name
    }
    
    public var successMessage: String {
        var fullname = ""
        if let practice = clinician.practiceName {
            fullname = "with \n\n\(practice)"
        }
        if let name = clinician.name {
            if !fullname.isEmpty {
                fullname.append("'s ")
            } else {
                fullname.append("with \n\n")
            }
            fullname.append(name)
            
        }
        
        return "Your appointment \(fullname) \n\nfor \(service.attributes.description) \n\nat \(location.attributes.name) \n\non \(apptTime.dateString), \(apptTime.timeString) \n\nis confirmed."
        
    }
}
