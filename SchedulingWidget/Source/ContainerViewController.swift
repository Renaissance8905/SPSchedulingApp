//
//  ContainerViewController.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

protocol Container: class {
    func setTitle(_: String?)
    func requestConfirmation(_ confirmation: @escaping (Bool) -> Void)
    func dismissWidget()
}

class ContainerViewController: UIViewController, SchedulingViewController {
    
    // Note: this must be the ONLY strong reference to the widget
    var widget: SchedulingWidget?
    
    @IBOutlet private var containerView: UIView?
    @IBOutlet private var closeBtn: UIButton?
    @IBOutlet fileprivate var practiceNameLbl: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        setTitle(nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // late in the game but the frame isn't always right earlier
        embedSplitView()
    }
    
    private func embedSplitView() {
        guard let widget = widget else { return dismissWidget() }
        let splitViewController = SchedulingSplitViewController.viewController(with: widget)
        addChild(splitViewController)
        containerView?.addSubview(splitViewController.view)
        splitViewController.didMove(toParent: self)
        
    }
    
    private func configureButton() {
        closeBtn?.formatAsSelectButton("Cancel")
        closeBtn?.addTarget(self, action: #selector(dismissWidget), for: .touchUpInside)
    }
    
}

extension ContainerViewController: Container {
    
    func setTitle(_ practiceName: String?) {
        practiceNameLbl?.text = practiceName
        
    }
    
    func requestConfirmation(_ confirmation: @escaping (Bool) -> Void) {
        let alert = UIAlertController.appointmentConfirmation(confirmation)
        present(alert, animated: true)
        
    }
    
    @objc func dismissWidget() {
        dismiss(animated: true)
        
    }
    
}
