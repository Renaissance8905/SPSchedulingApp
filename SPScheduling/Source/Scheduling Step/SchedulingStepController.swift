//
//  SchedulingStepController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

class SchedulingStepController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchedulingStepCell.register(to: tableView)
//        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
}

extension SchedulingStepController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let step = SchedulingStep(rawValue: indexPath.row + 1)
        return SchedulingStepCell.cell(for: tableView, with: SchedulingStepViewModel(step!, currentStep: .location, detailText: Array(repeating: "Hello There", count: indexPath.row)))
    }
    
}
