//
//  SettingCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class SettingCoordinator: AppCoordinator {
    
    var settingViewController: SettingViewController?
 
    override func start() {
        let viewModel = SettingViewModel()
        viewModel.coordinator = self
        
        settingViewController = SettingViewController(viewModel: viewModel)
        guard let setting = settingViewController else { return }
        
        let topVC = window.rootViewController?.topViewController()
        topVC?.navigationController?.pushViewController(setting, animated: true)
    }
    
}

extension SettingCoordinator: SettingViewModelCoordinator {
    
}
