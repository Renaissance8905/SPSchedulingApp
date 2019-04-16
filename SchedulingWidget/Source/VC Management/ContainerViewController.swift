//
//  ContainerViewController.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/14/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

protocol Container: class {
    func setTitle(_: String?)
    
    func showMenuBtn(_ show: Bool)
    func requestConfirmation(_ confirmation: @escaping (Bool) -> Void)
    func dismissWidget()
}

class ContainerViewController: UIViewController, SchedulingViewController {
    
    // Note: this must be the ONLY strong reference to the widget
    var widget: SchedulingWidget?
    
    @IBOutlet private var containerView: UIView?
    @IBOutlet private var closeBtn: UIButton?
    @IBOutlet private var menuBtn: UIButton?
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
        
        menuBtn?.setImage(SchedulingImage.menu.image, for: .normal)
        menuBtn?.tintColor = .lightGray
        menuBtn?.setTitle(nil, for: .normal)
        menuBtn?.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        menuBtn?.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.menuBtn?.isHidden = !self.isCompactWidth
        }
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

    @objc func showMenu() {
        (children.first as? StepUpdateListener)?.showMenu()
        showMenuBtn(false)
    }
    
    func showMenuBtn(_ show: Bool) {
        guard isCompactWidth else { return }
        
        menuBtn?.isEnabled = show
        UIView.animate(withDuration: 0.5) {
            self.menuBtn?.isHidden = !show
        }
        
    }
    
}
