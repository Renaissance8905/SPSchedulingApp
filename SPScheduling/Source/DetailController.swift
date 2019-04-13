//
//  DetailController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import Foundation
import UIKit

class DetailController: UIViewController {
    
    weak var widget: SchedulingWidget?
    
    var listener: StepUpdateListener? {
        return splitViewController as? StepUpdateListener
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(increment))
        view.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBackground()
    }
    
    func updateBackground() {
        view.backgroundColor = bkgrdColor
    }
    
    var bkgrdColor: UIColor {
        switch widget?.activeStep {
        case .clinician?: return .blue
        case .service?: return .green
        case .location?: return .red
        case .dateTime?: return .yellow
        case .info?: return .purple
        default: return .black
        }
    }
    
    @objc public func increment() {
        widget?.incrementActiveStep()
        updateBackground()
        listener?.didUpdateStep()
        
    }
    
}
