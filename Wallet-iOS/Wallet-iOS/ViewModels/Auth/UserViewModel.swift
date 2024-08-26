//
//  UserViewModel.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import Foundation

protocol UserViewModelCoordinator {}

class UserViewModel: ViewModelProtocol {
    
    var coordinator: UserViewModelCoordinator?
    
    let dateModel: UserDataModelProtocol
    
    init(dateModel: UserDataModelProtocol = UserDataModel()) {
        self.dateModel = dateModel
    }
    
}
