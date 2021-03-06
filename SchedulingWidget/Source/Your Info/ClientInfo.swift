//
//  ClientInfo.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

// Stub Model to simulate data outside the scope of this widget

struct ClientInfo: SchedulingData {
    var name: String
    var age: Int
    var catCount: Int
    
    var textRepresentation: [String] {
        return [
            name,
            "Age: \(age == -1 ? "gettin up there" : String(age))",
            "Cats: \(catCount)"
        ]
    }
}
