//
//  SendTxViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/25.
//

import UIKit

class SendTxViewController: BaseViewController<SendTxViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel.setup()
        }
    }
    
}
