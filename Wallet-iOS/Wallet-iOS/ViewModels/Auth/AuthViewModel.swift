//
//  AuthViewModel.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import Foundation
import Web3Auth

protocol AuthViewModelCoordinator {
    
}

class AuthViewModel: ViewModelProtocol {
    
    var coordinator: AuthViewModelCoordinator?
    
    let clientId = "BMOysTorFajRIKzocJdtuXd_VFuywM5pkByV2NZ2arhqYSRv_p92rraMlgUE1G6dfaCS0SNX52vNvBHb4l9ZRWc"
    let network: Network = .testnet
    
    var web3Auth: Web3Auth?
    var user: Web3AuthState?
    var isLoading = false
    var loggedIn: Bool = false
    
    let dateModel: AuthDataModelProtocol
    
    init(dataModel: AuthDataModelProtocol = AuthDataModel()) {
        self.dateModel = dataModel
    }

    func setup() async {
        guard web3Auth == nil else { return }
        await MainActor.run(body: {
            isLoading = true
        })
        
        // IMP START - Initialize Web3Auth
        do {
            web3Auth = try await Web3Auth(W3AInitParams(
                clientId: clientId,
                network: network,
                redirectUrl: "web3auth.ios-example://auth"
            ))
            
            print("Auth is ready")
        } catch {
            print("Something went wrong")
        }
        // IMP END - Initialize Web3Auth
        await MainActor.run(body: {
            if self.web3Auth?.state != nil {
                user = web3Auth?.state
                loggedIn = true
            }
            isLoading = false
        })
    }
    
    func loginEmailPasswordless(provider: Web3AuthProvider, email: String) {
        Task {
            do {
                // IMP START - Login
                let result = try await web3Auth?.login(W3ALoginParams(loginProvider: provider, extraLoginOptions: ExtraLoginOptions(display: nil, prompt: nil, max_age: nil, ui_locales: nil, id_token_hint: nil, id_token: nil, login_hint: email, acr_values: nil, scope: nil, audience: nil, connection: nil, domain: nil, client_id: nil, redirect_uri: nil, leeway: nil, verifierIdField: nil, isVerifierIdCaseSensitive: nil, additionalParams: nil)))
                // IMP END - Login
                await MainActor.run(body: {
                    user = result
                    loggedIn = true
                })
                
            } catch {
                print("Error")
            }
        }
    }
    
}
