//
//  SchedulingSplitViewContoller.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

protocol StepUpdateListener {
    func didUpdateStep()
}

class SchedulingSplitViewController: UISplitViewController, StepUpdateListener {
    
    weak var widget: SchedulingWidget?
    
    class func viewController(with widget: SchedulingWidget?) -> SchedulingSplitViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        let controller = storyboard.instantiateInitialViewController() as? SchedulingSplitViewController
        controller?.widget = widget
        return controller ?? SchedulingSplitViewController()
        
    }
    
    var stepController: SchedulingStepController? {
        return (viewControllers.first as? UINavigationController)?.topViewController as? SchedulingStepController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepController?.widget = widget
        showDetailViewController()
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    func didUpdateStep() {
        stepController?.update()
        showDetailViewController()
    }
    
    func showDetailViewController() {
        guard let detail = widget?.viewControllerForActiveStep else { return }
        showDetailViewController(detail, sender: self)
        
    }
    
}
