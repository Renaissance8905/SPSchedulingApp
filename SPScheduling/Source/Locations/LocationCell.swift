//
//  LocationCell.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class LocationCell: CollectionCell {
    
    @IBOutlet var nameLbl: UILabel?
    @IBOutlet var address1Lbl: UILabel?
    @IBOutlet var address2Lbl: UILabel?
    @IBOutlet var phoneLbl: UILabel?
    @IBOutlet var selectBtn: UIButton?
    
    private var location: Location?
    
    var selectionBlock: ((Location) -> Void)?
    
    class func cell(for collectionView: UICollectionView, indexPath: IndexPath, location: Location, selectionBlock: ((Location) -> Void)?) -> LocationCell {
        let cell = LocationCell.cell(for: collectionView, for: indexPath) ?? LocationCell()
        cell.location = location
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
        configureForLocation()
        
    }
    
    func configureForLocation() {
        
        nameLbl?.text = location?.attributes.name
        address1Lbl?.text = location?.attributes.addressLine1
        address2Lbl?.text = location?.attributes.addressLine2
        phoneLbl?.text = location?.attributes.phone
        
        layoutSubviews()
        
    }
    
    private func configureButton() {
        selectBtn?.formatAsSelectButton()
        selectBtn?.addTarget(self, action: #selector(update), for: .touchUpInside)
    }
    
    @objc func update() {
        guard let location = location else { return }
        selectionBlock?(location)
        
    }
}

