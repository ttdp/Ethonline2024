//
//  AuthViewController.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import UIKit
import SwiftUI

class AuthViewController: BaseViewController<AuthViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpViews() {
        let hostingController = UIHostingController(rootView: LoginView())
        guard let loginView = hostingController.view else { return }
        
        view.addSubview(loginView)
        view.addConstts(format: "H:|[v0]|", views: loginView)
        view.addConstts(format: "V:|[v0]|", views: loginView)
    }
    
}
