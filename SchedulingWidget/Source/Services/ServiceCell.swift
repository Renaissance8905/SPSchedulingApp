//
//  ServiceCell.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class ServiceCell: CollectionCell {

    @IBOutlet var nameLbl: UILabel?
    @IBOutlet var timeLbl: UILabel?
    @IBOutlet var selectBtn: UIButton?
    
    var service: Service?
    
    var selectionBlock: ((Service) -> Void)?
    
    class func cell(for collectionView: UICollectionView, indexPath: IndexPath, with service: Service, _ selectionBlock: ((Service) -> Void)?) -> ServiceCell {
        let cell = ServiceCell.cell(for: collectionView, for: indexPath) ?? ServiceCell()
        cell.service = service
        cell.selectionBlock = selectionBlock
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        setShadowAndCornerRadius()
        configureButton()
        configureForService()
        
    }
    
    func configureForService() {
        nameLbl?.text = service?.attributes.description
        timeLbl?.text = "\(service?.attributes.duration ?? 0) minutes"
        layoutSubviews()
        
    }
    
    private func configureButton() {
        selectBtn?.formatAsSelectButton()
        selectBtn?.addTarget(self, action: #selector(update), for: .touchUpInside)
    }
    
    @objc func update() {
        guard let service = service else { return }
        selectionBlock?(service)
        
    }
}
