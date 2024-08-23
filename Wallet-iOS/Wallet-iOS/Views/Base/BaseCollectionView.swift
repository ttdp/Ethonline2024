//
//  BaseCollectionView.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class BaseCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        backgroundColor = Colors.systemBackground_primary
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        setUpViews()
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    
    func setUpViews() {
        // Override by subclass
    }
    
    // MARK: - Toast
    
    func success(_ message: String) {
        let toast = Toast(title: message, type: .success)
        toast.show()
    }
    
    func warning(_ message: String) {
        let toast = Toast(title: message, type: .warning)
        toast.show()
    }
    
    func error(_ message: String) {
        let toast = Toast(title: message, type: .error)
        toast.show()
    }
    
}
