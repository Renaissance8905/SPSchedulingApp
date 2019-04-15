//
//  SchedulingWidget.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

public struct Appointment {
    var clinician: Clinician
    var service: Service
    var location: Location
    var apptTime: AppointmentTime
    var clientInfo: ClientInfo
    
    public var clientName: String {
        return clientInfo.name
    }
    
    public var successMessage: String {
        var fullname = ""
        if let practice = clinician.practiceName {
            fullname = "with \n\n\(practice)"
        }
        if let name = clinician.name {
            if !fullname.isEmpty {
                fullname.append("'s ")
            } else {
                fullname.append("with \n\n")
            }
            fullname.append(name)
            
        }
        
        return "Your appointment \(fullname) \n\nfor \(service.attributes.description) \n\nat \(location.attributes.name) \n\non \(apptTime.dateString), \(apptTime.timeString) \n\nis confirmed."

    }
}

public class SchedulingWidget: SchedulingWidgetProtocol {
    
    public static func launchWithClinician(_ clinician: Clinician?, apiClient: APIClient, presenter: UIViewController, result: AppointmentReturn) {
        SchedulingWidget(apiClient: apiClient, clinician: clinician).launch(presenter, result: result)
    }
    
    private var appointmentReturnBlock: AppointmentReturn = nil
    private weak var widgetView: Container? // TODO try to get rid of this reference
    
    private let dataManager: DataManager
    private let progress: SchedulingProgressModel

    required init(apiClient: APIClient, clinician: Clinician?) {
        
        dataManager = HybridDataManager(apiClient)
        progress = SchedulingProgressModel(clinician: clinician)
        
    }
    
    var title: String? {
        return progress.clinician?.practiceName
        
    }
    
    func rollBackActiveStep(to indexPath: IndexPath) {
        progress.rollBackActiveStep(to: indexPath)
        
    }
    
    func incrementActiveStep(_ didIncrement: () -> Void) {
        guard progress.canIncrement else {
            return requestConfirmation()
        }
        
        progress.incrementActiveStep()
        didIncrement()
        
    }
    
    func submitAppointment() {
        guard let appt = progress.appointment else { return }
        appointmentReturnBlock?(appt)
        widgetView?.dismissWidget()
        
    }
    
    func requestConfirmation() {
        widgetView?.requestConfirmation({ [weak self] (confirmed) in
            if confirmed {
                self?.submitAppointment()
            }
        })
        
    }
    
    func stepViewModel(for indexPath: IndexPath) -> SchedulingStepViewModel? {
        return progress.stepViewModel(for: indexPath)
        
    }
    
    func launch(_ presenter: UIViewController, result: AppointmentReturn) {
        appointmentReturnBlock = result
        let containerVC = ContainerViewController.viewController(with: self)
        widgetView = containerVC
        presenter.present(containerVC, animated: true)
        
    }
    
    var viewControllerForActiveStep: UIViewController {
        return progress.activeStep.viewController(self)
        
    }
    
    func set(_ data: SchedulingData) {
        progress.set(data)
    }
    
}

extension SchedulingWidget { // DataManager Proxy
    
    func fetchServices(_ completion: @escaping ServicesCompletion) {
        guard let clinician = progress.clinician else {
            return completion(nil)
        }
        
        dataManager.getServices(for: clinician, completion)
        
    }
    
    func fetchLocations(_ completion: @escaping LocationsCompletion) {
        guard let clinician = progress.clinician, let service = progress.service else {
            return completion(nil)
        }
        
        dataManager.getLocations(for: clinician, service: service, completion)
        
    }
    
}

