//
//  DateTimeViewController.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit


class DateTimeViewController: UIViewController, SchedulingDetailViewController {
    
    weak var widget: SchedulingWidget?
    
    @IBOutlet var selectBtn: UIButton?
    
    private func configureButton() {
        selectBtn?.formatAsSelectButton("Sounds groovy")
        selectBtn?.addTarget(self, action: #selector(selectClinician), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    @objc func selectClinician() {
        widget?.set(AppointmentTime(date: Date() + 1.days))
        updateAndNotify()
    }
    
}

