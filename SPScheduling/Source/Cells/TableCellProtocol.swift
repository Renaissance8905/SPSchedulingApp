//
//  TableCellProtocol.swift
//  SPScheduling
//
//  Created by Christopher Spradling on 4/11/19.
//  Copyright © 2019 cspantech. All rights reserved.
//

import UIKit

typealias TableCell = UITableViewCell & CellProtocol
typealias CollectionCell = UICollectionViewCell & CellProtocol

protocol CellProtocol {
    static var identifier: String   { get }
    static var nibName: String      { get }
}

extension CellProtocol where Self: UIView {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static var nibName: String {
        return identifier
    }
    
    fileprivate static var nib: UINib? {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
    
}

extension CellProtocol where Self: UITableViewCell {
    
    static func register(to tableView: UITableView?) {
        tableView?.register(nib, forCellReuseIdentifier: identifier)
    }
    
    static func cell(for tableView: UITableView?) -> Self? {
        return tableView?.dequeueReusableCell(withIdentifier: identifier) as? Self
    }
    
}

extension CellProtocol where Self: UICollectionViewCell {
    
    static func register(to collection: UICollectionView?) {
        collection?.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    static func cell(for collection: UICollectionView?, for indexPath: IndexPath) -> Self? {
        return collection?.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self
    }
    
}

