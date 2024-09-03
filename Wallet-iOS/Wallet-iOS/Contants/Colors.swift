//
//  Colors.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

struct Colors {
    
    static let gradientBlueFrom = UIColor(hex: "#0061ff")
    static let gradientBlueTo = UIColor(hex: "#60efff")
    
    static let separator = UIColor.separator
    
    static let label_primary: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#BBBBBB")
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#444444")
            }
        }
    }()
    
    static let label_secondary = UIColor.secondaryLabel
    static let label = UIColor.label
    
    static let systemBackground_primary = UIColor.systemBackground
    static let systemBackground_secondary = UIColor.secondarySystemBackground
    static let systemBackground_tertiary = UIColor.tertiarySystemBackground
    
    static let groupedBackground_primary = UIColor.systemGroupedBackground
    static let groupedBackground_secondary = UIColor.secondarySystemGroupedBackground
    static let groupedBackground_tertiary = UIColor.tertiarySystemGroupedBackground
    
}
