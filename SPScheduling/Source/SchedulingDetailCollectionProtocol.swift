//
//  SchedulingDetailCollectionProtocol.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/13/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

protocol SchedulingCollectionViewController: SchedulingDetailViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    associatedtype DataType: SchedulingData
    associatedtype CellType: CollectionCell
    
    var collectionView: UICollectionView?       { get set }
    var data: [DataType]                        { get set }
    var selectionBlock: ((DataType) -> Void)?   { get }
    
    func updateData()
    
}

extension SchedulingCollectionViewController where Self: UIViewController {
    
    static func viewController(with widget: SchedulingWidget) -> Self {
        var vc = Self.init()
        vc.widget = widget
        return vc
        
    }
    
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .collectionViewBackgroundColor
        self.collectionView = collectionView
        
        registerCell()
        
    }
    
    func registerCell() {
        CellType.register(to: collectionView)
    }
    
    func willDisplay(_ cell: UICollectionViewCell) {
        (cell as? CellType)?.configure()
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil) { (_) in
            self.collectionView?.invalidateIntrinsicContentSize()
            self.collectionView?.layoutIfNeeded()
        }
    }
    
}


