//
//  SchedulingStepCell.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class SchedulingStepCell: TableCell {
    
    @IBOutlet var numberLbl: UILabel?
    @IBOutlet var titleLbl: UILabel?
    @IBOutlet var detailLblStack: UIStackView?
    
    static func cell(for tableView: UITableView, with viewModel: SchedulingStepViewModel) -> SchedulingStepCell {
        let cell = self.cell(for: tableView) ?? SchedulingStepCell()
        cell.configure(with: viewModel)
        return cell
    }
    
    func configure(with step: SchedulingStepViewModel) {
        configureNumberLbl(with: step)
        configureTitleLbl(with: step)
        configureDetailText(with: step)
        
        selectionStyle = .none
    }
    
    private func configureNumberLbl(with step: SchedulingStepViewModel) {
        guard let numberLbl = numberLbl else { return }
        numberLbl.text = step.index
        numberLbl.layer.borderColor = step.indexColor.cgColor
        numberLbl.layer.borderWidth = 1
        numberLbl.layer.cornerRadius = numberLbl.frame.height / 2
        numberLbl.textColor = step.indexColor

    }
    
    private func configureTitleLbl(with step: SchedulingStepViewModel) {
        titleLbl?.text = step.title
        titleLbl?.textColor = step.titleColor
        titleLbl?.font = step.titleFont
        
    }
    
    private func configureDetailText(with step: SchedulingStepViewModel) {
        guard let stack = detailLblStack else { return }
        
        for subView in stack.arrangedSubviews {
            stack.removeArrangedSubview(subView)
        }

        for detail in step.detailText {
            let detailLbl = UILabel()
            detailLbl.text = detail
            detailLbl.textColor = .secondaryBlue
            stack.addArrangedSubview(detailLbl)
        }

        
    }
    
}
