//
//  Reusable+Extension.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension UICollectionReusableView: Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseId: String { return String(describing: self) }

}

extension Reusable where Self: UICollectionViewCell {

    static var reuseId: String { return String(describing: self) }

}

extension Reusable where Self: UICollectionReusableView {
    
    static var reuseId: String { return String(describing: self) }
    
}

extension UITableView {
    
    func register<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueReusable<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else {
            fatalError("Unknow cell at \(indexPath)")
        }
        return cell
    }

}

extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
    }
    
    func registerHeaderView<View: UICollectionReusableView>(_ viewClass: View.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: viewClass.reuseId)
    }
    
    func registerFooterView<View: UICollectionReusableView>(_ viewClass: View.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: viewClass.reuseId)
    }
    
    func dequeueReusable<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell else { fatalError("Unknow cell at \(indexPath)")
        }
        return cell
    }
    
    func dequeueReusableHeader<View: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> View {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: View.reuseId, for: indexPath) as? View else {
            fatalError("Unknow header view at \(indexPath)")
        }
        return view
    }
    
    func dequeueReusableFooter<View: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> View {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: View.reuseId, for: indexPath) as? View else {
            fatalError("Unknow footer view at \(indexPath)")
        }
        return view
    }
    
}

