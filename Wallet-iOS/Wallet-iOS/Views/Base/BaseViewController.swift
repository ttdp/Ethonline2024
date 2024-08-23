//
//  BaseViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class BaseViewController<T: ViewModelProtocol>: UIViewController {
    
    let viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.systemBackground_primary
        setUpViews()
    }
    
    // MARK: - View
    
    var naviGap = Screen.naviGap
    var bottomGap = Screen.bottomGap
    
    let naviEdge: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let bottomEdge: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
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
