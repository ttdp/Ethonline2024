//
//  BalanceViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation

protocol ViewModelProtocol {}

protocol BalanceViewModelCoordinator {}

class BalanceViewModel: ViewModelProtocol {
    
    var coordinator: BalanceViewModelCoordinator?
    
    let dataModel: BalanceDataModelProtocol
    
    init(dataModel: BalanceDataModelProtocol = BalanceDataModel()) {
        self.dataModel = dataModel
    }
    
}
