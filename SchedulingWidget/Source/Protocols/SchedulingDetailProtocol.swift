//
//  SchedulingDetailViewControllerProtocol.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

protocol SchedulingDetailViewController: SchedulingViewController {}

extension SchedulingDetailViewController where Self: UIViewController {
    
    func updateAndNotify() {
        let listener = splitViewController as? StepUpdateListener
        listener?.didUpdateStep()
        widget?.incrementActiveStep() {
            listener?.updateDetail()
        }
    }
    
}
