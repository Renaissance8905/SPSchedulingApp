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
    var id: String
    var url: String
    var name: String?
    var practiceName: String?
    
    var textRepresentation: [String] {
        guard let name = name, !name.isEmpty else { return [] }
        return [name]
    }
    
    public init(id: String, url: String, name: String?, practiceName: String?) {
        self.id = id
        self.url = url
        self.name = name
        self.practiceName = practiceName
    }
    
}
