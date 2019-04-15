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
            print(appt)
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
    
}

