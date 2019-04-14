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

public typealias AppointmentReturn = ((Appointment) -> Void)?

public protocol SchedulingWidgetProtocol {
    func launch(_ presenter: UIViewController, result: AppointmentReturn)
    func launch(_ presenter: UIViewController, with clinician: Clinician?, result: AppointmentReturn)
}


public struct Appointment {
    var clinician: Clinician
    var service: Service
    var location: Location
    var apptTime: AppointmentTime
    var clientInfo: ClientInfo
}

public class SchedulingWidget {
    
    let dataManager: DataManager
    
    init(apiClient: APIClient = APIClient()) {
        dataManager = HybridDataManager(apiClient)
//        dataManager = StubDataManager()
    }
    
    // determines whether this widget was launched with a specific clinician selected,
    // in which case the first step will not be editable
    private var clinicianLocked = false
    
    var activeStep: SchedulingStep = .clinician {
        didSet {
            // clear out data selections for all steps after active step
            switch activeStep {
            case .clinician:
                service = nil
                fallthrough
            case .service:
                location = nil
                fallthrough
            case .location:
                apptTime = nil
                fallthrough
            case .dateTime:
                yourInfo = nil
            case .info:
                return
            }
            
        }
        
    }
    
    var clinician: Clinician?
    var service: Service?
    var location: Location?
    var apptTime: AppointmentTime?
    var yourInfo: ClientInfo?
    
    private func data(for step: SchedulingStep) -> SchedulingData? {
        switch step {
        case .clinician: return clinician
        case .service:   return service
        case .location:  return location
        case .dateTime:  return apptTime
        case .info:      return yourInfo
            
        }
        
    }
    
    private func step(for indexPath: IndexPath) -> SchedulingStep? {
        return SchedulingStep(rawValue: indexPath.row + 1)
        
    }
    
    func rollBackActiveStep(to indexPath: IndexPath) {
        // We only want to be able to decrement the active step by indexPath,
        // incrementing will be triggered when a selection is made
        guard let active = step(for: indexPath), active.index < activeStep.index else { return }
        guard !(activeStep == .clinician && clinicianLocked) else { return }
        activeStep = active
        
    }
    
    func incrementActiveStep() {
        if case .info = activeStep {
            
            // TODO confirm and return appointment
            
            return
        }
        
        activeStep = SchedulingStep(rawValue: activeStep.index + 1) ?? activeStep
        
    }
    
    func stepViewModel(for indexPath: IndexPath) -> SchedulingStepViewModel? {
        guard let step = step(for: indexPath) else { return nil }
        return SchedulingStepViewModel(step, currentStep: activeStep, detailText: data(for: step)?.textRepresentation)
        
    }
    
    func launch(_ presenter: UIViewController, with clinician: Clinician? = nil, result: AppointmentReturn) {
        self.clinician = clinician
        clinicianLocked = true
        let splitViewController = SchedulingSplitViewController.viewController(with: self)
        presenter.present(splitViewController, animated: true, completion: nil)
        
    }
    
    var viewControllerForActiveStep: UIViewController {
        return viewController(for: activeStep)
        
    }
    
    func viewController(for step: SchedulingStep) -> UIViewController {
        switch step {
        case .clinician:
            return ClinicianViewController.viewController(with: self)
        case .service:
            return ServicesCollectionViewController.viewController(with: self)
        case .location:
            return LocationsCollectionViewController.viewController(with: self)
        case .dateTime:
            return DateTimeViewController.viewController(with: self)
        case .info:
            return YourInfoViewController.viewController(with: self)
        }
    }
    
}

extension SchedulingWidget { // DataManager Proxy
    
    func fetchServices(_ completion: @escaping ServicesCompletion) {
        guard let clinician = clinician else {
            return completion(nil)
        }
        dataManager.getServices(for: clinician, completion)
    }
    
    func fetchLocations(_ completion: @escaping LocationsCompletion) {
        guard let clinician = clinician, let service = service else {
            return completion(nil)
        }
        dataManager.getLocations(for: clinician, service: service, completion)
        
    }
    
}
