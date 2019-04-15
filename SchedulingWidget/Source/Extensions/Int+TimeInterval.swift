//
//  Int+TimeInterval.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

extension Int {
    
    var seconds: TimeInterval { return Double(self) }
    var minutes: TimeInterval { return seconds * 60 }
    var hours:   TimeInterval { return minutes * 60 }
    var days:    TimeInterval { return hours * 24   }
    
}
