//
//  BaseTableView.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class BaseTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        backgroundColor = Colors.systemBackground_primary
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
