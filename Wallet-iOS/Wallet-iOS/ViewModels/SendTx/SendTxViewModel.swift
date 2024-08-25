//
//  SendTxViewModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/25.
//

import Foundation

protocol SendTxViewModelCoordinator {
    
}

class SendTxViewModel: ViewModelProtocol {
    
    var coordinator: SendTxViewModelCoordinator?
    
    let dateModel: SendTxDataModelProtocol
    
    init(dataModel: SendTxDataModelProtocol = SendTxDataModel()) {
        self.dateModel = dataModel
    }
    
    func sendEther(address: String, value: Double, completion: @escaping () -> Void) {
        dateModel.sendTranscation(address: address, value: value) {
            DispatchQueue.main.async { completion() }
        }
    }
    
}
