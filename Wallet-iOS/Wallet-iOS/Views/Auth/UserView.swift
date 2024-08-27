//
//  UserView.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import SwiftUI
import Web3Auth

struct UserView: View {
    
    @State private var isPrivateKeySectionVisible = false
    @State private var showingAlert = false
    
    @StateObject var web3RPC: Web3RPC

    var body: some View {
        if let authState = AuthManager.shared.user {
            List {
                Section(header: Text("User Information")) {
                    Text("Name: \(authState.userInfo?.name ?? "")")
                    Text("Email: \(authState.userInfo?.email ?? "")")
                }

                Section(header: Text("Public Address")) {
                    Button {
                        web3RPC.getAccounts()
                    } label: {
                        Label("Get Public Address", systemImage: "person.crop.circle")
                    }
                    if !web3RPC.publicAddress.isEmpty {
                        Text("\(web3RPC.publicAddress)")
                    }
                }
                
                Section {
                    Button {
                        Task.detached {
                            do {
                                try AuthManager.shared.logout()
                            } catch {
                                DispatchQueue.main.async {
                                    showingAlert = true
                                }
                            }
                        }
                    } label: {
                        Label("Logout", systemImage: "arrow.left.square.fill")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Logout failed!"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
    
}
