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
    @IBOutlet var launchBtn: UIButton?
    
    private var inputURL: ClientURL? {
        return clientURLField?.text
    }
    
    private var inputID: ClinicianID? {
        return clinicianIDField?.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchBtn?.addTarget(self, action: #selector(launchScheduling), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clientURLField?.text = "https://johnny-appleseed.clientsecure.me"
        clinicianIDField?.text = "2"
        launchScheduling()
    }
    
    
    @objc func launchScheduling() {
        guard let url = inputURL, let id = inputID else { return }
        
        print("launching with url: \(url)\n          with id: \(id)")
        
        SchedulingWidget().launch(self, withURL: url, id: id)
        
    }
    
}
