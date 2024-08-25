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
    func fetchEthereumMainnet(address: String, completion: @escaping (String) -> Void)
    func fetchEthereumSepolia(address: String, completion: @escaping (String) -> Void)
    func fetchArbitrumMainnet(address: String, completion: @escaping (String) -> Void)
    func fetchArbitrumSepolia(address: String, completion: @escaping (String) -> Void)
    func fetchOptimismMainnet(address: String, completion: @escaping (String) -> Void)
    func fetchOptimismSepolia(address: String, completion: @escaping (String) -> Void)
    func fetchNFTs(address: String, completion: @escaping ([NFT]) -> Void)
}

class BalanceDataModel: BalanceDataModelProtocol {
    
    func fetchEthereumMainnet(address: String, completion: @escaping (String) -> Void) {
        fetchBalance(path: Paths.EthereumMainnet, address: address, completion: completion)
    }
    
    func fetchEthereumSepolia(address: String, completion: @escaping (String) -> Void) {
        fetchBalance(path: Paths.EthereumSepolia, address: address, completion: completion)
    }
    
    func fetchArbitrumMainnet(address: String, completion: @escaping (String) -> Void) {
        fetchBalance(path: Paths.ArbitrumMainnet, address: address, completion: completion)
    }
    
    func fetchArbitrumSepolia(address: String, completion: @escaping (String) -> Void) {
        fetchBalance(path: Paths.ArbitrumSepolia, address: address, completion: completion)
    }
    
    func fetchOptimismMainnet(address: String, completion: @escaping (String) -> Void) {
        fetchBalance(path: Paths.OptimismMainnet, address: address, completion: completion)
    }
    
    func fetchOptimismSepolia(address: String, completion: @escaping (String) -> Void) {
        fetchBalance(path: Paths.OptimismSepolia, address: address, completion: completion)
    }
    
    private func fetchBalance(path: String, address: String, completion: @escaping (String) -> Void) {
        let parameters: [String: Any] = ["id": 1, "jsonrpc": "2.0", "method": "eth_getBalance", "params": [address, "latest"]]
        
        AF.request(path, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: AlchemyResponse.self) { response in
            switch response.result {
            case .success(let alchemyResponse):
                guard let balanceInWei = alchemyResponse.result else { return }
                let balance = balanceInWei.weiToEther()
                completion(balance)
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNFTs(address: String, completion: @escaping ([NFT]) -> Void) {
        let nftPath = Paths.NFT
        
        let parameters: [String: Any] = ["owner": address]
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
    
    func hexStringToBigInt() -> BigInt? {
        // Remove "0x" if present
        let cleanHexString = self.lowercased().hasPrefix("0x")
        ? String(self.dropFirst(2))
        : self
        
        return BigInt(cleanHexString, radix: 16)
    }
    
    func weiToEther() -> String {
        guard let balanceInWei = self.hexStringToBigInt() else { return "" }
        let weiToEtherConversionFactor = BigUInt(10).power(18)
        let balanceInEther = Double(balanceInWei) / Double(weiToEtherConversionFactor)
        let balanceInEtherString = String(format: "%.4f", balanceInEther).removeTrailingZeros()
        return balanceInEtherString
    }
    
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
