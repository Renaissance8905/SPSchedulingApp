//
//  SchedulingStepController.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

class SchedulingStepController: UIViewController, SchedulingViewController {
    
    weak var widget: SchedulingWidget?
    
    var listener: StepUpdateListener? {
        return splitViewController as? StepUpdateListener
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchedulingStepCell.register(to: tableView)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
        widget?.hideMenuButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        widget?.showMenuButton()
    }
    
    func update() {
        tableView.reloadData()
        
    }
    
}

extension SchedulingStepController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SchedulingStep.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stepViewModel = widget?.stepViewModel(for: indexPath) else { return UITableViewCell() }
        return SchedulingStepCell.cell(for: tableView, with: stepViewModel)
    }
    
}

extension SchedulingStepController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let changed = widget?.rollBackActiveStep(to: indexPath) ?? false
        listener?.didUpdateStep()
        if isCompactWidth, let vc = widget?.viewController(for: indexPath) {
            navigationController?.pushViewController(vc, animated: true)
        } else if changed {
            listener?.updateDetail()

        }
        
    }
}
