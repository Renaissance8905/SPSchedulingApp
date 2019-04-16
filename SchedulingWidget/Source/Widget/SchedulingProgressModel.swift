//
//  SchedulingProgressModel.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/15/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation

class SchedulingProgressModel {
    
    var clinician: Clinician?
    var service: Service?
    var location: Location?
    var apptTime: AppointmentTime?
    var yourInfo: ClientInfo?
    
    // determines whether this widget was launched with a specific clinician selected,
    // in which case the first step will not be editable
    let clinicianLocked: Bool
    
    init(clinician: Clinician?) {
        self.clinician = clinician
        clinicianLocked = clinician != nil
        activeStep = SchedulingStep.allCases[clinicianLocked ? 1 : 0]
        
    }
    
    private(set) var activeStep: SchedulingStep {
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
    
    var appointment: Appointment? {
        guard
            let clinician = clinician,
            let service = service,
            let location = location,
            let apptTime = apptTime,
            let yourInfo = yourInfo
        else { return nil }
        
        return Appointment(clinician: clinician,
                           service: service,
                           location: location,
                           apptTime: apptTime,
                           clientInfo: yourInfo)
        
    }
    
    private func data(for step: SchedulingStep) -> SchedulingData? {
        switch step {
        case .clinician: return clinician
        case .service:   return service
        case .location:  return location
        case .dateTime:  return apptTime
        case .info:      return yourInfo
            
        }
        
    }
    
    func set(_ data: SchedulingData) {
        switch data {
        case is Clinician:       clinician = data as? Clinician
        case is Service:         service   = data as? Service
        case is Location:        location  = data as? Location
        case is AppointmentTime: apptTime  = data as? AppointmentTime
        case is ClientInfo:      yourInfo  = data as? ClientInfo
        default: return
            
        }
    }
    
    func rollBackActiveStep(to indexPath: IndexPath) -> Bool {
        // We only want to be able to decrement the active step by indexPath,
        // incrementing will be triggered when a selection is made
        guard let active = SchedulingStep(for: indexPath), active.index < activeStep.index else { return false }
        
        // If clinicianLocked == true, we cannot change the clinician
        // or access the Clinician selection screen
        guard !(active == .clinician && clinicianLocked) else { return false }
        
        activeStep = active
        return true
        
    }
    
    func incrementActiveStep() {
        activeStep = activeStep.next
        
    }
    
    var canIncrement: Bool {
        return activeStep != SchedulingStep.allCases.last
        
    }
    
    func stepViewModel(for indexPath: IndexPath) -> SchedulingStepViewModel? {
        guard let step = SchedulingStep(for: indexPath) else { return nil }
        return SchedulingStepViewModel(step, currentStep: activeStep, detailText: data(for: step)?.textRepresentation)
        
    }
    
}

