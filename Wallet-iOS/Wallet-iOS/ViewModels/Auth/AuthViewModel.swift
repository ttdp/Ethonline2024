//
//  AuthViewModel.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import Foundation

protocol AuthViewModelCoordinator {}

class AuthViewModel: ViewModelProtocol {
    
    var coordinator: AuthViewModelCoordinator?
    
    let dateModel: AuthDataModelProtocol
    
    init(dataModel: AuthDataModelProtocol = AuthDataModel()) {
        self.dateModel = dataModel
    }
    
}
