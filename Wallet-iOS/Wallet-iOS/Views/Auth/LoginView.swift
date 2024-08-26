//
//  LoginView.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var emailInput: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Web3Auth")
                .font(.title) // Adjust the font size as needed
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("Enter your email", text: $emailInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .padding(.horizontal, 10)
            
            Button(
                action: {
                    AuthManager.shared.loginEmailPasswordless(provider: .EMAIL_PASSWORDLESS, email: emailInput)
                },
                label: {
                    Text("Sign In with Email Passwordless")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            HStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                
                Text("or")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
            
            Button(
                action: {
                    AuthManager.shared.login(provider: .GOOGLE)
                },
                label: {
                    Text("Sign In with Google")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red) // Change color as needed
                        .cornerRadius(8)
                }
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            
            Button(
                action: {
                    AuthManager.shared.login(provider: .APPLE)
                },
                label: {
                    Text("Sign In with Apple")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black) // Change color as needed
                        .cornerRadius(8)
                }
            )
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
