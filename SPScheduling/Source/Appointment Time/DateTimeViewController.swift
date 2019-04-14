//
//  DateTimeViewController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit


class DateTimeViewController: UIViewController, SchedulingDetailViewController {
    
    weak var widget: SchedulingWidget?
    
    @IBOutlet var selectBtn: UIButton?
    
    private func configureButton() {
        selectBtn?.formatAsSelectButton()
        selectBtn?.setTitle("Sounds groovy", for: .normal)
        selectBtn?.addTarget(self, action: #selector(selectClinician), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    @objc func selectClinician() {
        widget?.apptTime = AppointmentTime(date: Date() + 1.days)
        updateAndNotify()
    }
    
}

