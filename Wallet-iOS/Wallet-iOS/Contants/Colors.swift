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
    
    static let systemFill = UIColor.systemFill
    static let systemGray = UIColor.systemGray
    static let separator = UIColor.separator
    static let placeholder = UIColor.placeholderText
    
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
    static let label_tertiary = UIColor.tertiaryLabel
    static let label_quaternary = UIColor.quaternaryLabel
    static let label_light = UIColor.lightText  // #A4A4A4
    static let label_dark = UIColor.darkText
    static let label = UIColor.label
    
    static let systemBackground_primary = UIColor.systemBackground
    static let systemBackground_secondary = UIColor.secondarySystemBackground
    static let systemBackground_tertiary = UIColor.tertiarySystemBackground
    
    static let groupedBackground_primary = UIColor.systemGroupedBackground
    static let groupedBackground_secondary = UIColor.secondarySystemGroupedBackground
    static let groupedBackground_tertiary = UIColor.tertiarySystemGroupedBackground
    
    static let wave_gradient_start = UIColor(hex: "#399a55")
    static let wave_gradient_end = UIColor(hex: "#94d8a8")
    
    static let greenLabel = UIColor(hex: "#5EBD3E")
    static let greenLabelBackground: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#5EBD3E").withAlphaComponent(0.2)
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#5EBD3E").withAlphaComponent(0.1)
            }
        }
    }()
    
    static let yellowLabel = UIColor(hex: "#FFB900")
    static let yellowLabelBackground: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#FFB900").withAlphaComponent(0.2)
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#FFB900").withAlphaComponent(0.1)
            }
        }
    }()
    
    static let orangeLabel = UIColor(hex: "#F78200")
    static let orangeLabelBackground: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#F78200").withAlphaComponent(0.2)
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#F78200").withAlphaComponent(0.1)
            }
        }
    }()
    
    static let redLabel = UIColor(hex: "#E23838")
    static let redLabelBackground: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#E23838").withAlphaComponent(0.2)
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#E23838").withAlphaComponent(0.1)
            }
        }
    }()
    
    static let violetLabel = UIColor(hex: "#973999")
    static let violetLabelBackground: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#973999").withAlphaComponent(0.2)
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#973999").withAlphaComponent(0.1)
            }
        }
    }()
    
    static let blueLabel = UIColor(hex: "#29ABE2")
    static let blueLabelBackground: UIColor = {
        return UIColor { (tc: UITraitCollection) -> UIColor in
            if tc.userInterfaceStyle == .dark {
                /// Return the color for Dark Mode
                return UIColor(hex: "#29ABE2").withAlphaComponent(0.2)
            } else {
                /// Return the color for Light Mode
                return UIColor(hex: "#29ABE2").withAlphaComponent(0.1)
            }
        }
    }()
    
    // Development
    
    static let one = UIColor(hex: "#ABCDEF")
    static let four = UIColor(hex: "#EFABCD")
    static let two = UIColor(hex: "#CDEFAB")
    static let three = UIColor(hex: "#F4AB6A")
    
}
