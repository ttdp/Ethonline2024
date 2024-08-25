//
//  SendTxDataModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/25.
//

import Foundation
import Alamofire

protocol SendTxDataModelProtocol {
    func sendTranscation(address: String, value: Double, completion: @escaping () -> Void)
}

class SendTxDataModel: SendTxDataModelProtocol {
    
    func sendTranscation(address: String, value: Double, completion: @escaping () -> Void) {
        let path = Paths.EthereumSepolia
        
        
    }
    
}
