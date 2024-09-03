//
//  Fonts.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

struct Fonts {
    
    static let label = Fonts.Roboto.Regular_16
    static let primary = Fonts.Roboto.Regular_18
    static let secondary = Fonts.Roboto.Regular_17
    
    static let Medium_22 = Fonts.Roboto.Medium_22
    static let Medium_28 = Fonts.Roboto.Medium_28
    static let Bold_32 = Fonts.Roboto.Bold_32

    private static let Roboto_Regular = "Roboto-Regular"
    private static let Roboto_Medium = "Roboto-Medium"
    private static let Roboto_Bold = "Roboto-Bold"
    
    struct Roboto {
        static let Regular_16 = UIFont(name: Fonts.Roboto_Regular, size: 16)
        static let Regular_17 = UIFont(name: Fonts.Roboto_Regular, size: 17)
        static let Regular_18 = UIFont(name: Fonts.Roboto_Regular, size: 18)

        static let Medium_22 = UIFont(name: Fonts.Roboto_Medium, size: 22)
        static let Medium_28 = UIFont(name: Fonts.Roboto_Medium, size: 28)

        static let Bold_32 = UIFont(name: Fonts.Roboto_Bold, size: 32)
    }
    
}
