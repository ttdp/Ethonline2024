//
//  NFTDataModel.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 9/2/24.
//

import Foundation
import Alamofire

protocol NFTDataModelProtocol {
    func fetchNFTs(address: String, completion: @escaping ([NFT]) -> Void)
}

class NFTDataModel: NFTDataModelProtocol {
    
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
