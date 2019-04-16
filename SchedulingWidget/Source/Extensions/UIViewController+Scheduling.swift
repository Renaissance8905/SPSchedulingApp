//
//  UIViewController+Scheduling.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/15/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

extension UIViewController {
    var isCompactWidth: Bool {
        // ignoring iPad Portrait, because while that slides out the menu controller it does not collapse it
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
