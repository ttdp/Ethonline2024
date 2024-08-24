//
//  AppCoordinator.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

var coordinatorStack = Stack<String>()

class AppCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        coordinatorStack.push("\(self)")
        print("✅ \(coordinatorStack)")
    }
    
    deinit {
        coordinatorStack.remove("\(self)")
        print("♻️ \(coordinatorStack)")
    }
    
    func start() {
        HostCoordinator(window: window).start()
    }
    
}
