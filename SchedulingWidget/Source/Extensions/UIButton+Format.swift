//
//  UIButton+Format.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

extension UIButton {
    
    func formatAsSelectButton(_ title: String? = "Select") {
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .primaryBlue
        layer.cornerRadius = 6
        contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
    }
}

