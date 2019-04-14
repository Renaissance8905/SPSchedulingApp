//
//  SchedulingDetailViewControllerProtocol.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

protocol SchedulingDetailViewController {
    var widget: SchedulingWidget? { get set }
}

extension SchedulingDetailViewController where Self: UIViewController {
    
    func updateAndNotify() {
        widget?.incrementActiveStep()
        (splitViewController as? StepUpdateListener)?.didUpdateStep()
    }
    
    static func viewController(with widget: SchedulingWidget) -> Self {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        var vc = storyboard.instantiateInitialViewController() as? Self ?? Self()
        vc.widget = widget
        return vc
    }
    
}
