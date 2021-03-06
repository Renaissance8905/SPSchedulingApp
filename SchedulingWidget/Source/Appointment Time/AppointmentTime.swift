//
//  AppointmentTIme.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

// Stub Model to simulate data outside the scope of this widget

struct AppointmentTime: SchedulingData {
    var date: Date
    var textRepresentation: [String] {
        return [dateString, timeString]
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
        
    }
}
