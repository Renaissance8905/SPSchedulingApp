//
//  LaunchViewController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
        
    @IBOutlet var clientURLField: UITextField?
    @IBOutlet var clinicianIDField: UITextField?
    @IBOutlet var clinicianNameField: UITextField?
    @IBOutlet var clinicianPracticeNameField: UITextField?
    
    @IBOutlet var launchWithClinicianBtn: UIButton?
    @IBOutlet var coldLaunchBtn: UIButton?
    
    private var clinician: Clinician? {
        guard
            let id = clinicianIDField?.text,
            let url = clientURLField?.text,
            !id.isEmpty,
            !url.isEmpty
        else { return nil }
        let name = clinicianNameField?.text
        let practice = clinicianPracticeNameField?.text
        
        return Clinician(id: id, url: url, name: name, practiceName: practice)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchWithClinicianBtn?.addTarget(self, action: #selector(launchScheduling), for: .touchUpInside)
        coldLaunchBtn?.addTarget(self, action: #selector(launchScheduling), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clientURLField?.text = "https://johnny-appleseed.clientsecure.me"
        clinicianIDField?.text = "2"
        clinicianNameField?.text = "Rob Gross, MFT"
        clinicianPracticeNameField?.text = "House of Wellness"
    }
    
    @objc func launchScheduling(_ sender: UIButton) {
        
        let resultBlock: AppointmentReturn = { appt in
            DispatchQueue.main.async {
                self.displayAppointment(appt)
            }
        }
        
        switch sender {
        case launchWithClinicianBtn:
            guard let clinician = clinician else { return }
            SchedulingWidget.launchWithClinician(clinician, presenter: self, result: resultBlock)
        case coldLaunchBtn:
            SchedulingWidget.launch(presenter: self, result: resultBlock)
        default:
            return
        }
        
    }
    
    func displayAppointment(_ appt: Appointment) {
        var fullname = ""
        if let practice = appt.clinician.practiceName {
            fullname = "with \n\n\(practice)"
        }
        if let name = appt.clinician.name {
            if !fullname.isEmpty {
                fullname.append("'s ")
            } else {
                fullname.append("with \n\n")
            }
            fullname.append(name)
            
        }
        
        let message = "Your appointment \(fullname) \n\nfor \(appt.service.attributes.description) \n\nat \(appt.location.attributes.name) \n\non \(appt.apptTime.dateString), \(appt.apptTime.timeString) \n\nis confirmed."
        let alert = UIAlertController(title: "Congrats, \(appt.clientInfo.name)!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cool thx", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}

