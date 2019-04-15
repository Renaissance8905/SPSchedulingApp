//
//  UIAlertController+Alerts.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func appointmentConfirmation(_ handler: @escaping (Bool) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Confirm Appointment?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Looks good", style: .default) { _ in
            handler(true)
        })
        alert.addAction(UIAlertAction(title: "I need to make adjustments", style: .cancel) { _ in
            handler(false)
        })
        
        return alert
    }
    
}
