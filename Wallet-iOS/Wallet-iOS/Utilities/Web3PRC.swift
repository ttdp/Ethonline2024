//
//  Web3PRC.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import Foundation
import BigInt
import Web3Auth
import web3

class Web3RPC : ObservableObject {
    var user: Web3AuthState
    private var client: EthereumClientProtocol
    public var address: EthereumAddress
    private var account: EthereumAccount
    private var latestBlock = 0
    private var chainID = 11155111
    private var RPC_URL = "https://rpc.ankr.com/eth_sepolia"
    
    @Published var balance: Double = 0
    @Published var signedMessageHashString:String = ""
    @Published var sentTransactionID:String = ""
    @Published var publicAddress: String = ""
    
    init?(user: Web3AuthState){
        self.user = user
        do{
            client = EthereumHttpClient(url: URL(string: RPC_URL)!, network: .fromString("11155111"))
            account = try EthereumAccount(keyStorage: user as EthereumSingleKeyStorageProtocol )
            address = account.address
        } catch {
             return nil
        }
    }
    
    func getAccounts() {
        self.publicAddress = address.asString()
        print(address.asString())
    }
    
    func checkLatestBlockChanged() async -> Bool {
        return await withCheckedContinuation({ continuation in
            client.eth_blockNumber { [weak self] result in
                switch result {
                case .success(let val):
                    if self?.latestBlock != val {
                        self?.latestBlock = val
                        continuation.resume(returning: true)
                    } else {
                        continuation.resume(returning: false)
                    }
                case .failure:
                    continuation.resume(returning: false)
                }
            }
        })
    }

    // IMP START - Blockchain Calls
    func getBalance() {
        Task {
            let blockChanged = await checkLatestBlockChanged()
            guard blockChanged == true else {
                return
            }
            let _ = client.eth_getBalance(address: self.address, block: .Latest) { [unowned self] result in
                switch result {
                case .success(let weiValue):
                    let balance = Web3AuthWeb3Utils.toEther(wei: weiValue) // Access the value directly
                    DispatchQueue.main.async { [weak self] in
                        self?.balance = balance
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func signMessage() {
        do {
            let val = try account.sign(message: "Hello World")
            self.signedMessageHashString = val.web3.hexString
            print(self.signedMessageHashString)
        } catch {
            self.signedMessageHashString = "Something Went Wrong"
        }
    }
    
    func sendTransaction()  {
        Task{
            do {
                let val = try await transferAsset(sendTo: "0x24BfD1c2D000EC276bb2b6af38C47390Ae6B5FF0", amount: 0.0001, maxTip: 0.0001)
                self.sentTransactionID = val
                print(val)
            } catch let error {
                print("error: ", error)
                self.sentTransactionID = "Something Went Wrong, please check if you have insufficient funds"
            }
        }
    }
    
    func transferAsset(sendTo: String, amount: Double, maxTip: Double, gasLimit: BigUInt = 21000) async throws -> String {
        let gasPrice = try await client.eth_gasPrice()
        let maxTipInGwie = BigUInt(Web3AuthWeb3Utils.toEther(Gwie: BigUInt(amount)))
        let totalGas = gasPrice + maxTipInGwie
        let amtInGwie = Web3AuthWeb3Utils.toWei(ether: amount)
        let nonce = try await client.eth_getTransactionCount(address: address, block: .Latest)
        let transaction = EthereumTransaction(from: address, to: EthereumAddress(sendTo), value: amtInGwie, data: Data(), nonce: nonce + 1, gasPrice: totalGas, gasLimit: gasLimit, chainId: chainID)
        let signed = try account.sign(transaction: transaction)
        let val = try await client.eth_sendRawTransaction(signed.transaction, withAccount: account)
        return val
    }
    // IMP END - Blockchain Calls
    
}

extension Web3AuthState: EthereumSingleKeyStorageProtocol {
    
    public func storePrivateKey(key: Data) throws {
        
    }
    
    public func loadPrivateKey() throws -> Data {
        guard let privKeyData = self.privKey?.web3.hexData else {
            throw SampleAppError.somethingWentWrong
        }
        return privKeyData
        
    }
    
}

public enum SampleAppError:Error{
    case noInternetConnection
    case decodingError
    case somethingWentWrong
    case customErr(String)
}
