//
//  ServicesCollectionViewController.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class ServicesCollectionViewController: UIViewController, SchedulingCollectionViewController {
    
    typealias DataType = Service
    typealias CellType = ServiceCell
    
    var collectionView: UICollectionView?
    
    weak var widget: SchedulingWidget?
    var data: [Service] = [] {
        didSet { collectionView?.reloadData() }
    }
    
    private(set) var selectionBlock: ((Service) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        selectionBlock = { [weak self] service in
            self?.widget?.set(service)
            self?.updateAndNotify()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCollectionView()
        
    }
    
    func updateData() {
        
        widget?.fetchServices() { [weak self] data in
            DispatchQueue.main.async {
                self?.data = data ?? []
            }
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 500, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 100, bottom: 20, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return ServiceCell.cell(for: collectionView, indexPath: indexPath, with: data[indexPath.section], selectionBlock)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplay(cell)
    }
    
}
