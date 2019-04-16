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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sizeCollectionView()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (transitioner) in
            self.collectionView?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        })
    }
    
    func updateData() {
        
        widget?.fetchServices() { [weak self] data in
            DispatchQueue.main.async {
                self?.data = data ?? []
            }
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 0.8, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 0, bottom: 300, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 500
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return ServiceCell.cell(for: collectionView, indexPath: indexPath, with: data[indexPath.item], selectionBlock)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplay(cell)
    }
    
}
