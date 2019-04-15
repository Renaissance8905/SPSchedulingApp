//
//  SchedulingViewControllerProtocol.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

protocol SchedulingViewController where Self: UIViewController {
    var widget: SchedulingWidget? { get set }
}

extension SchedulingViewController {
    
    static func viewController(with widget: SchedulingWidget) -> Self {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        var vc = storyboard.instantiateInitialViewController() as? Self ?? Self()
        vc.widget = widget
        return vc
    }
    
}
