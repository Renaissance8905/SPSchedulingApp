//
//  SchedulingStepController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

protocol SchedulingData {
    var textRepresentation: [String] { get }
}

class SchedulingProgressViewModel {
    
    var activeStep: SchedulingStep = .clinician {
        didSet {
            // clear out data selections for all steps at and after active step
            switch activeStep {
            case .clinician:
                clinician = nil
                fallthrough
            case .service:
                service = nil
                fallthrough
            case .location:
                location = nil
                fallthrough
            case .info, .dateTime:
                return
            }
        }
    }
    
    var clinician: Clinician?
    var service: Service?
    var location: Location?
    
    private func data(for step: SchedulingStep) -> SchedulingData? {
        switch step {
        case .clinician: return clinician
        case .service:   return service
        case .location:  return location
        default:         return nil // out of scope for this widget
            
        }
    }
    
    private func step(for indexPath: IndexPath) -> SchedulingStep? {
        return SchedulingStep(rawValue: indexPath.row + 1)
    }
    
    func rollBackActiveStep(to indexPath: IndexPath) {
        // We only want to be able to decrement the active step by indexPath,
        // incrementing will be triggered when a selection is made
        guard let active = step(for: indexPath), active.index < activeStep.index else { return }
        activeStep = active
        
    }
    
    func incrementActiveStep() {
        activeStep = SchedulingStep(rawValue: activeStep.index + 1) ?? activeStep
        
    }
    
    func stepViewModel(for indexPath: IndexPath) -> SchedulingStepViewModel? {
        guard let step = step(for: indexPath) else { return nil }
        return SchedulingStepViewModel(step, currentStep: activeStep, detailText: data(for: step)?.textRepresentation)
        
    }
    
}

class SchedulingStepController: UIViewController {
    
    var viewModel: SchedulingProgressViewModel? = SchedulingProgressViewModel()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchedulingStepCell.register(to: tableView)
        tableView?.delegate = self
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
        return SchedulingStep.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stepViewModel = viewModel?.stepViewModel(for: indexPath) else { return UITableViewCell() }
        return SchedulingStepCell.cell(for: tableView, with: stepViewModel)
    }
    
}

extension SchedulingStepController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.rollBackActiveStep(to: indexPath)
        tableView.reloadData()
    }
}
