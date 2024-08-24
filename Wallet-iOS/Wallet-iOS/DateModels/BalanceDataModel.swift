//
//  BalanceDataModel.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import Foundation
import web3swift
import Web3Core
import BigInt
import Alamofire

protocol BalanceDataModelProtocol {
    func fetchBalance(address: EthereumAddress, comletion: @escaping (String) -> Void)
    func fetchNFTs(address: EthereumAddress, completion: @escaping ([NFT]) -> Void)
}

class BalanceDataModel: BalanceDataModelProtocol {
    
    func fetchBalance(address: EthereumAddress, comletion: @escaping (String) -> Void) {
        Task {
            let balancePath = Paths.Ethereum
            let web3 = try! await Web3.new(URL(string: balancePath)!)
            
            do {
                let balanceResult = try await web3.eth.getBalance(for: address)
                
                let balanceInWei = balanceResult
                let weiToEtherConversionFactor = BigUInt(10).power(18)
                let balanceInEther = Double(balanceInWei) / Double(weiToEtherConversionFactor)
                let balanceInEtherString = String(format: "%.4f", balanceInEther).removeTrailingZeros()
                
                comletion(balanceInEtherString)
            } catch {
                print("Error fetching balance: \(error)")
            }
        }
    }
    
    func fetchNFTs(address: EthereumAddress, completion: @escaping ([NFT]) -> Void) {
        let nftPath = Paths.NFT
        
        let parameters: [String: Any] = ["owner": address.address]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(nftPath, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: NFTResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.ownedNfts)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}

extension String {
    
    func removeTrailingZeros() -> String {
        if let number = Double(self) {
            // Convert the number back to a string with no trailing zeros
            let formattedString = String(format: "%g", number)
            return formattedString
        } else {
            return self // Return the original value if conversion fails
        }
    }
    
}
