//
//  Screen.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

struct Screen {
    
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
    
    static let halfHeight = UIScreen.main.bounds.height / 2
    static let halfWidth = UIScreen.main.bounds.width / 2
    
    static let thirdHeight = UIScreen.main.bounds.height / 3
    static let thirdWidth = UIScreen.main.bounds.width / 3
    
    static let quarterHeight = UIScreen.main.bounds.height / 4
    static let quarterWidth = UIScreen.main.bounds.width / 4
    
    static let imageHeightPadding_15 = (UIScreen.main.bounds.width - 30) * 9 / 16
    static let imageHeightPadding_30 = (UIScreen.main.bounds.width - 60) * 9 / 16
    static let imageHeightPadding_130 = (UIScreen.main.bounds.width - 130) * 9 / 16
    
    static var hasTopNotch: Bool {
        if #available(iOS 12.0, *) {
            let windowSence = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegaet = windowSence?.delegate as? SceneDelegate
            
            return sceneDelegaet?.window?.safeAreaInsets.top ?? 0 > 24
        }
        
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24
        }
        
        return false
    }
    
    /*
     The default navigation bar height is 64 = status(20) + navigantion(44)
     The default tab bar height is 50
     iPhone X top + 24, bottom + 34
     */
    
    static var naviGap: CGFloat {
        return Screen.hasTopNotch ? 88.0 : 64.0
    }
    
    static var bottomGap: CGFloat {
        return Screen.hasTopNotch ? 34.0 : 0.0
    }
    
}
