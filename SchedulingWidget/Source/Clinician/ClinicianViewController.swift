//
//  ClinicianViewController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class ClinicianViewController:  UIViewController, SchedulingDetailViewController {
    
    weak var widget: SchedulingWidget?
    
    @IBOutlet var clientURLField: UITextField?
    @IBOutlet var clinicianIDField: UITextField?
    @IBOutlet var clinicianNameField: UITextField?
    @IBOutlet var selectBtn: UIButton?
    
    private var inputURL: String? {
        return clientURLField?.text
    }
    
    private var inputID: String? {
        return clinicianIDField?.text
    }
    
    private var inputName: String? {
        return clinicianNameField?.text
    }
    
    
    private func configureButton() {
        selectBtn?.formatAsSelectButton()
        selectBtn?.addTarget(self, action: #selector(selectClinician), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clientURLField?.text = "https://johnny-appleseed.clientsecure.me"
        clinicianIDField?.text = "2"
        clinicianNameField?.text = "Rob Gross, MFT"
        
    }
    
    @objc func selectClinician() {
        guard let url = inputURL, let id = inputID, let name = inputName else { return }
        let clinician = Clinician(id: id, url: url, name: name, practiceName: "House of Wellness")
        widget?.set(clinician)
        updateAndNotify()
    }
    
}

