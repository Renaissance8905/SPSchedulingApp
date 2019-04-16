//
//  SchedulingSplitViewContoller.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

protocol StepUpdateListener {
    func didUpdateStep()
    func updateDetail()
    func showMenu()
}

class SchedulingSplitViewController: UISplitViewController, SchedulingViewController, StepUpdateListener {
    
    weak var widget: SchedulingWidget?
    
    var stepController: SchedulingStepController? {
        return (viewControllers.first as? UINavigationController)?.topViewController as? SchedulingStepController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepController?.widget = widget
        setContainerTitle()
        showDetailViewController()
        delegate = widget
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    func didUpdateStep() {
        stepController?.update()
        setContainerTitle()
    }
    
    func updateDetail() {
        showDetailViewController()
    }
    
    func setContainerTitle() {
        (parent as? Container)?.setTitle(widget?.title)
    }
    
    func showDetailViewController() {
        guard let detail = widget?.viewControllerForActiveStep else { return }
        showDetailViewController(detail, sender: self)
    }
    
    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        if isCompactWidth {
            showMenu()
        } else {
            super.showDetailViewController(vc, sender: sender)
        }
        
    }
    
    func showMenu() {
        (viewControllers.first as? UINavigationController)?.popToRootViewController(animated: true)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        let nav = stepController?.navigationController ?? (viewControllers.first as? UINavigationController)
        let actualVC = (vc as? UINavigationController)?.topViewController ?? vc
        nav?.pushViewController(actualVC, animated: true)
    }
    
    private func setStepControllerIfNeeded() {
        guard self.stepController?.view.window == nil else { return }
        guard let widget = widget else { return }
        let stepController = self.stepController ?? SchedulingStepController.viewController(with: widget)
        (viewControllers.first as? UINavigationController)?.setViewControllers([stepController], animated: true)
    }
    
}
