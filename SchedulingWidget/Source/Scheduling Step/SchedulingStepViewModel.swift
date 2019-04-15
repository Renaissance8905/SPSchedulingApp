//
//  SchedulingStepViewModel.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/12/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

struct SchedulingStepViewModel {
    
    var step: SchedulingStep
    var currentStep: SchedulingStep
    var detailText: [String]
    
    var state: State
    
    enum State {
        case filled, active, pending
    }
    
    init(_ step: SchedulingStep, currentStep: SchedulingStep, detailText: [String]?) {
        self.step = step
        self.currentStep = currentStep
        self.detailText = detailText ?? []
        
        switch currentStep.index {
        case 0..<step.index: state = .pending
        case step.index:     state = .active
        default:             state = .filled
        }
        
    }
    
    var index: String {
        return String(step.index)
    }
    
    var title: String {
        return step.title
    }
    
    var indexColor: UIColor {
        switch state {
        case .filled:  return .black
        case .active:  return .secondaryBlue
        case .pending: return .lightGray
        }
    }
    
    var titleColor: UIColor {
        switch state {
        case .filled:  return .black
        case .active:  return .black
        case .pending: return .lightGray
        }
    }
    
    var payloadTextColor: UIColor {
        return .secondaryBlue
    }
    
    var titleFont: UIFont {
        return UIFont.systemFont(ofSize: state == .active ? 16 :14)
    }
    
}
