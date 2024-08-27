//
//  AuthManager.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import Foundation
import Web3Auth

class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    let clientId = "BMOysTorFajRIKzocJdtuXd_VFuywM5pkByV2NZ2arhqYSRv_p92rraMlgUE1G6dfaCS0SNX52vNvBHb4l9ZRWc"
    let network: Network = .sapphire_devnet
    
    var web3Auth: Web3Auth?
    
    @Published var user: Web3AuthState?
    @Published var isLoading = false
    @Published var loggedIn: Bool = false
    
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
        } catch {
            print("Something went wrong")
        }
        
        // IMP END - Initialize Web3Auth
        await MainActor.run(body: {
            if self.web3Auth?.state != nil {
                user = web3Auth?.state
                loggedIn = true
                
                notifyAuthState()
            }
            isLoading = false
        })
    }
    
    func login(provider: Web3AuthProvider) {
        Task {
            do {
                let result = try await web3Auth?.login(
                    W3ALoginParams(loginProvider: provider)
                )
                await MainActor.run(body: {
                    user = result
                    loggedIn = true
                    notifyAuthState()
                    
                    GlobalCoordinator.dismiss()
                })
            } catch {
                print("Error")
            }
        }
    }
    
    func logout() throws {
        Task {
            try await web3Auth?.logout()
            await MainActor.run(body: {
                user = nil
                loggedIn = false
                notifyAuthState()
                
                GlobalCoordinator.dismiss()
            })
        }
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
                    notifyAuthState()
                    
                    GlobalCoordinator.dismiss()
                })
            } catch {
                print("Error")
            }
        }
    }
    
    private func notifyAuthState() {
        if let user = user, let web3RPC = Web3RPC(user: user) {
            let publicAddress = web3RPC.address.asString()
            NotificationCenter.default.post(name: .authState, object: publicAddress)
        } else {
            NotificationCenter.default.post(name: .authState, object: nil)
        }
    }
    
}
