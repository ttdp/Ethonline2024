//
//  BaseView.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.systemBackground_primary
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        // Overwrite by sub-class
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
