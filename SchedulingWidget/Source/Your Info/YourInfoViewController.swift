//
//  YourInfoViewController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit


class YourInfoViewController: UIViewController, SchedulingDetailViewController {
    
    weak var widget: SchedulingWidget?
    
    @IBOutlet var userNameField: UITextField?
    @IBOutlet var userAgeField: UITextField?
    @IBOutlet var userCatsField: UITextField?
    @IBOutlet var selectBtn: UIButton?
    
    private var inputName: String? {
        return userNameField?.text
    }
    
    private var inputAge: Int? {
        guard let ageText = userAgeField?.text else { return nil }
        return Int(ageText) ?? -1
    }
    
    private var inputCats: Int? {
        switch userCatsField?.text {
        case .none:
            return nil
        case "I'm more of a dog person, myself":
            return -1
        case .some(let txt):
            return Int(txt) ?? 0
        }
    }
    
    
    private func configureButton() {
        selectBtn?.formatAsSelectButton()
        selectBtn?.addTarget(self, action: #selector(selectClientInfo), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userNameField?.text = "Baggins, Bilbo"
        userAgeField?.text = "111"
        userCatsField?.text = "I'm more of a dog person, myself"
    }
    
    @objc func selectClientInfo() {
        guard let name = inputName, let age = inputAge, let cats = inputCats else { return }
        
        widget?.set(ClientInfo(name: name, age: age, catCount: cats))
        
        updateAndNotify()
    }
    
}

