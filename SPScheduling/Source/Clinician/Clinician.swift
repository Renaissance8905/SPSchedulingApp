//
//  Clinician.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

// Stub Model to simulate data outside the scope of this widget

public struct Clinician: SchedulingData {
    var id: ClinicianID
    var url: ClientURL
    var name: String
    
    var textRepresentation: [String] {
        return [name]
    }
}
