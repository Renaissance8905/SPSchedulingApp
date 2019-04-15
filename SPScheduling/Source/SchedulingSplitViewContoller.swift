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
    func updateDetail()
}

class SchedulingSplitViewController: UISplitViewController, SchedulingViewController, StepUpdateListener {
    
    weak var widget: SchedulingWidget?
    
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
        (parent as? Container)?.setTitle(widget?.title)
    }
    
    func updateDetail() {
        showDetailViewController()
    }
    
    func showDetailViewController() {
        guard let detail = widget?.viewControllerForActiveStep else { return }
        showDetailViewController(detail, sender: self)
        
    }
    
}
