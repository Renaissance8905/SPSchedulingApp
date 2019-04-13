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

public class SchedulingWidget {
    
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
    
    func launch(_ presenter: UIViewController, with clinician: Clinician) {
        let splitViewController = SchedulingSplitViewController.viewController(with: self)
        presenter.present(splitViewController, animated: true, completion: nil)
        
    }
    
    func viewController(for step: SchedulingStep) -> UIViewController {
        let vc = DetailController()
        vc.widget = self
        return vc
        
    }
    
    var viewControllerForActiveStep: UIViewController {
        return viewController(for: activeStep)
        
    }
    
}
