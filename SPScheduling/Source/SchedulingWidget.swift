//
//  SchedulingWidget.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

typealias ClientURL = String
typealias ClinicianID = String

class SchedulingWidget {
    
    public func launch(_ presenter: UIViewController, with clinician: Clinician) {
        guard let splitViewController = UIStoryboard(name: "SchedulingController", bundle: nil).instantiateInitialViewController() as? MySplitView else {
            return
        }
        presenter.present(splitViewController, animated: true, completion: nil)
        

    }
}


class MySplitView: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.preferredDisplayMode = .allVisible
    }
}
