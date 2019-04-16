//
//  UIImage+Sheduling.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/15/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

enum SchedulingImage: String {
    
    case cancel, menu
    
    var image: UIImage? {
        return UIImage(named: rawValue, in: Bundle(for: SchedulingWidget.self), compatibleWith: nil)
    }
}
