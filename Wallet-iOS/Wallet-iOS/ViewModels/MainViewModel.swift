//
//  MainViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation

protocol ViewModelProtocol {}

protocol MainViewModelCoordinator {}

class MainViewModel: ViewModelProtocol {
    
    var coordinator: MainViewModelCoordinator?
    
    let dataModel: MainDataModelProtocol
    
    init(dataModel: MainDataModelProtocol = MainDataModel()) {
        self.dataModel = dataModel
    }
    
}
