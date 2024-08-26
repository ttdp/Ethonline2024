//
//  UserViewController.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import UIKit
import SwiftUI

class UserViewController: BaseViewController<UserViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpViews() {
        guard let state = AuthManager.shared.user else { return }
        guard let web3RPC = Web3RPC(user: state) else { return }
        
        let hostingController = UIHostingController(rootView: UserView(web3RPC: web3RPC))
        
        guard let userView = hostingController.view else { return }
        
        view.addSubview(userView)
        view.addConstts(format: "H:|[v0]|", views: userView)
        view.addConstts(format: "V:|[v0]|", views: userView)
    }
    
}
