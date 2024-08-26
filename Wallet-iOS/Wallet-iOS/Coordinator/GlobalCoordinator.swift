//
//  GlobalCoordinator.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/26/24.
//

import UIKit

class GlobalCoordinator {
    
    private static var window: UIWindow? = {
        let windowSence = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegaet = windowSence?.delegate as? SceneDelegate
        return sceneDelegaet?.window
    }()
    
    private init() {}
    
    class func dismiss() {
        let topVC = window?.rootViewController?.topViewController()
        topVC?.dismiss(animated: true)
    }
    
}
