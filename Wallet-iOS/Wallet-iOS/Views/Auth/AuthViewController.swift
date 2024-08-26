//
//  AuthViewController.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import UIKit

class AuthViewController: BaseViewController<AuthViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel.setup()
        }
    }
    
    override func setUpViews() {
        view.backgroundColor = .systemBlue
    }
    
}

