//
//  LocationsCollectionViewController.swift
//  SchedulingWidget
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

class LocationsCollectionViewController: UIViewController, SchedulingCollectionViewController {
    
    typealias DataType = Location
    typealias CellType = LocationCell
    
    var collectionView: UICollectionView?
    
    weak var widget: SchedulingWidget?
    var data: [Location] = [] {
        didSet { collectionView?.reloadData() }
    }
    
    private(set) var selectionBlock: ((Location) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        selectionBlock = { [weak self] location in
            self?.widget?.set(location)
            self?.updateAndNotify()
        }
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
        widget?.fetchLocations() { [weak self] data in
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
        
        return CGSize(width: 200, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 40, bottom: 300, right: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return LocationCell.cell(for: collectionView, indexPath: indexPath, location: data[indexPath.item], selectionBlock: selectionBlock)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplay(cell)
    }
    
    
}
