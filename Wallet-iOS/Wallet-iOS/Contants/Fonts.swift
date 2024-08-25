//
//  Fonts.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

struct BSFont {
    
    static let fullName = Fonts.Roboto.Medium_18
    static let username = Fonts.Roboto.Italic_17
    static let timestamp = Fonts.Roboto.Italic_16
    static let date = Fonts.Roboto.Regular_16
    static let label = Fonts.Roboto.Regular_16
    static let footer = Fonts.Roboto.Light_14
    static let light = Fonts.Roboto.Light_15
    static let hint = Fonts.Roboto.Light_13

    static let primary = Fonts.Roboto.Regular_18
    static let secondary = Fonts.Roboto.Regular_17
    
    static let primaryMedium = Fonts.Roboto.Medium_18
    static let secondaryMedium = Fonts.Roboto.Medium_17
    
    static let primaryMediumItalic = Fonts.Roboto.MediumItalic_18
    static let secondaryMediumItalic = Fonts.Roboto.MediumItalic_17
    
    static let Medium_12 = Fonts.Roboto.Medium_12
    static let Medium_14 = Fonts.Roboto.Medium_14
    static let Medium_15 = Fonts.Roboto.Medium_15
    static let Medium_16 = Fonts.Roboto.Medium_16
    static let Medium_18 = Fonts.Roboto.Medium_18
    static let Medium_20 = Fonts.Roboto.Medium_20
    static let Medium_22 = Fonts.Roboto.Medium_22
    static let Medium_24 = Fonts.Roboto.Medium_24
    static let Medium_30 = Fonts.Roboto.Medium_30
    static let Medium_40 = Fonts.Roboto.Medium_40
    static let Regular_40 = Fonts.Roboto.Regular_40
    static let Regular_14 = Fonts.Roboto.Regular_14
    static let Regular_15 = Fonts.Roboto.Regular_15
    static let Regular_22 = Fonts.Roboto.Regular_22
}

struct Fonts {
    
    private static let Roboto_Regular = "Roboto-Regular"
    private static let Roboto_Italic = "Roboto-Italic"
    private static let Roboto_Thin = "Roboto-Thin"
    private static let Roboto_ThinItalic = "Roboto-ThinItalic"
    private static let Roboto_Light = "Roboto-Light"
    private static let Roboto_LightItalic = "Roboto-LightItalic"
    private static let Roboto_Medium = "Roboto-Medium"
    private static let Roboto_MediumItalic = "Roboto-MediumItalic"
    private static let Roboto_Bold = "Roboto-Bold"
    private static let Roboto_BoldItalic = "Roboto-BoldItalic"
    private static let Roboto_Black = "Roboto-Black"
    private static let Roboto_BlackItalic = "Roboto-BlackItalic"
    private static let Poppins_SmeiBold = "Poppins-SemiBold"
    
    struct Poppins {
        static let SemiBold_24 = UIFont(name: Fonts.Poppins_SmeiBold, size: 24)
        static let SemiBold_25 = UIFont(name: Fonts.Poppins_SmeiBold, size: 25)
    }
    
    struct Roboto {
        static let Regular_12 = UIFont(name: Fonts.Roboto_Regular, size: 12)
        static let Regular_14 = UIFont(name: Fonts.Roboto_Regular, size: 14)
        static let Regular_15 = UIFont(name: Fonts.Roboto_Regular, size: 15)
        static let Regular_16 = UIFont(name: Fonts.Roboto_Regular, size: 16)
        static let Regular_17 = UIFont(name: Fonts.Roboto_Regular, size: 17)
        static let Regular_18 = UIFont(name: Fonts.Roboto_Regular, size: 18)
        static let Regular_22 = UIFont(name: Fonts.Roboto_Regular, size: 22)
        static let Regular_40 = UIFont(name: Fonts.Roboto_Regular, size: 40)
        
        static let Light_13 = UIFont(name: Fonts.Roboto_Light, size: 13)
        static let Light_14 = UIFont(name: Fonts.Roboto_Light, size: 14)
        static let Light_15 = UIFont(name: Fonts.Roboto_Light, size: 15)
        static let Light_16 = UIFont(name: Fonts.Roboto_Light, size: 16)
        static let Light_17 = UIFont(name: Fonts.Roboto_Light, size: 17)
        static let Light_18 = UIFont(name: Fonts.Roboto_Light, size: 18)
        
        static let Italic_16 = UIFont(name: Fonts.Roboto_Italic, size: 16)
        static let Italic_17 = UIFont(name: Fonts.Roboto_Italic, size: 17)
        static let Italic_18 = UIFont(name: Fonts.Roboto_Italic, size: 18)
        
        static let ThinItalic_16 = UIFont(name: Fonts.Roboto_ThinItalic, size: 16)
        static let LightItalic_16 = UIFont(name: Fonts.Roboto_LightItalic, size: 16)
        static let LightItalic_17 = UIFont(name: Fonts.Roboto_LightItalic, size: 17)
        static let LightItalic_18 = UIFont(name: Fonts.Roboto_LightItalic, size: 18)
        
        static let Medium_12 = UIFont(name: Fonts.Roboto_Medium, size: 12)
        static let Medium_14 = UIFont(name: Fonts.Roboto_Medium, size: 14)
        static let Medium_15 = UIFont(name: Fonts.Roboto_Medium, size: 15)
        static let Medium_16 = UIFont(name: Fonts.Roboto_Medium, size: 16)
        static let Medium_17 = UIFont(name: Fonts.Roboto_Medium, size: 17)
        static let Medium_18 = UIFont(name: Fonts.Roboto_Medium, size: 18)
        static let Medium_20 = UIFont(name: Fonts.Roboto_Medium, size: 20)
        static let Medium_22 = UIFont(name: Fonts.Roboto_Medium, size: 22)
        static let Medium_24 = UIFont(name: Fonts.Roboto_Medium, size: 24)
        static let Medium_30 = UIFont(name: Fonts.Roboto_Medium, size: 30)
        static let Medium_40 = UIFont(name: Fonts.Roboto_Medium, size: 40)
        
        static let MediumItalic_16 = UIFont(name: Fonts.Roboto_MediumItalic, size: 16)
        static let MediumItalic_17 = UIFont(name: Fonts.Roboto_MediumItalic, size: 17)
        static let MediumItalic_18 = UIFont(name: Fonts.Roboto_MediumItalic, size: 18)
        
        static let Bold_16 = UIFont(name: Fonts.Roboto_Bold, size: 16)
        static let Bold_17 = UIFont(name: Fonts.Roboto_Bold, size: 17)
        static let Bold_18 = UIFont(name: Fonts.Roboto_Bold, size: 18)
        static let Bold_25 = UIFont(name: Fonts.Roboto_Bold, size: 25)
    }
    
    struct AvenirNext {
        static let Regular_14 = UIFont(name: "AvenirNext-Regular", size: 14)
        static let Regular_15 = UIFont(name: "AvenirNext-Regular", size: 15)
        static let Regular_16 = UIFont(name: "AvenirNext-Regular", size: 16)
        static let Regular_17 = UIFont(name: "AvenirNext-Regular", size: 17)
        static let Regular_18 = UIFont(name: "AvenirNext-Regular", size: 18)
        static let Regular_20 = UIFont(name: "AvenirNext-Regular", size: 20)
        static let Regular_24 = UIFont(name: "AvenirNext-Regular", size: 24)
        static let Regular_28 = UIFont(name: "AvenirNext-Regular", size: 28)
        
        static let Italic_14 = UIFont(name: "AvenirNext-Italic", size: 14)
        static let Italic_15 = UIFont(name: "AvenirNext-Italic", size: 15)
        static let Italic_16 = UIFont(name: "AvenirNext-Italic", size: 16)
        static let Italic_17 = UIFont(name: "AvenirNext-Italic", size: 17)
        static let Italic_18 = UIFont(name: "AvenirNext-Italic", size: 18)
        static let Italic_20 = UIFont(name: "AvenirNext-Italic", size: 20)
        static let Italic_24 = UIFont(name: "AvenirNext-Italic", size: 24)
        static let Italic_28 = UIFont(name: "AvenirNext-Italic", size: 28)
        
        static let UltraLight_14 = UIFont(name: "AvenirNext-UltraLight", size: 14)
        static let UltraLight_15 = UIFont(name: "AvenirNext-UltraLight", size: 15)
        static let UltraLight_16 = UIFont(name: "AvenirNext-UltraLight", size: 16)
        static let UltraLight_17 = UIFont(name: "AvenirNext-UltraLight", size: 17)
        static let UltraLight_18 = UIFont(name: "AvenirNext-UltraLight", size: 18)
        static let UltraLight_20 = UIFont(name: "AvenirNext-UltraLight", size: 20)
        static let UltraLight_24 = UIFont(name: "AvenirNext-UltraLight", size: 24)
        static let UltraLight_28 = UIFont(name: "AvenirNext-UltraLight", size: 28)
        
        static let UltraLightItalic_14 = UIFont(name: "AvenirNext-UltraLightItalic", size: 14)
        static let UltraLightItalic_15 = UIFont(name: "AvenirNext-UltraLightItalic", size: 15)
        static let UltraLightItalic_16 = UIFont(name: "AvenirNext-UltraLightItalic", size: 16)
        static let UltraLightItalic_17 = UIFont(name: "AvenirNext-UltraLightItalic", size: 17)
        static let UltraLightItalic_18 = UIFont(name: "AvenirNext-UltraLightItalic", size: 18)
        static let UltraLightItalic_20 = UIFont(name: "AvenirNext-UltraLightItalic", size: 20)
        static let UltraLightItalic_24 = UIFont(name: "AvenirNext-UltraLightItalic", size: 24)
        static let UltraLightItalic_28 = UIFont(name: "AvenirNext-UltraLightItalic", size: 28)
        
        static let Medium_12 = UIFont(name: "AvenirNext-Medium", size: 12)
        static let Medium_13 = UIFont(name: "AvenirNext-Medium", size: 13)
        static let Medium_14 = UIFont(name: "AvenirNext-Medium", size: 14)
        static let Medium_15 = UIFont(name: "AvenirNext-Medium", size: 15)
        static let Medium_16 = UIFont(name: "AvenirNext-Medium", size: 16)
        static let Medium_17 = UIFont(name: "AvenirNext-Medium", size: 17)
        static let Medium_18 = UIFont(name: "AvenirNext-Medium", size: 18)
        static let Medium_20 = UIFont(name: "AvenirNext-Medium", size: 20)
        static let Medium_24 = UIFont(name: "AvenirNext-Medium", size: 24)
        static let Medium_28 = UIFont(name: "AvenirNext-Medium", size: 28)
        
        static let MediumItalic_14 = UIFont(name: "AvenirNext-MediumItalic", size: 14)
        static let MediumItalic_15 = UIFont(name: "AvenirNext-MediumItalic", size: 15)
        static let MediumItalic_16 = UIFont(name: "AvenirNext-MediumItalic", size: 16)
        static let MediumItalic_17 = UIFont(name: "AvenirNext-MediumItalic", size: 17)
        static let MediumItalic_18 = UIFont(name: "AvenirNext-MediumItalic", size: 18)
        static let MediumItalic_20 = UIFont(name: "AvenirNext-MediumItalic", size: 20)
        static let MediumItalic_24 = UIFont(name: "AvenirNext-MediumItalic", size: 24)
        static let MediumItalic_28 = UIFont(name: "AvenirNext-MediumItalic", size: 28)
        
        static let DemiBold_14 = UIFont(name: "AvenirNext-DemiBold", size: 14)
        static let DemiBold_15 = UIFont(name: "AvenirNext-DemiBold", size: 15)
        static let DemiBold_16 = UIFont(name: "AvenirNext-DemiBold", size: 16)
        static let DemiBold_17 = UIFont(name: "AvenirNext-DemiBold", size: 17)
        static let DemiBold_18 = UIFont(name: "AvenirNext-DemiBold", size: 18)
        static let DemiBold_20 = UIFont(name: "AvenirNext-DemiBold", size: 20)
        static let DemiBold_24 = UIFont(name: "AvenirNext-DemiBold", size: 24)
        static let DemiBold_28 = UIFont(name: "AvenirNext-DemiBold", size: 28)
        
        static let DemiBoldItalic_14 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 14)
        static let DemiBoldItalic_15 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 15)
        static let DemiBoldItalic_16 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 16)
        static let DemiBoldItalic_17 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 17)
        static let DemiBoldItalic_18 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 18)
        static let DemiBoldItalic_20 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 20)
        static let DemiBoldItalic_24 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 24)
        static let DemiBoldItalic_28 = UIFont(name: "AvenirNext-DemiBoldItalic", size: 28)
        
        static let Bold_14 = UIFont(name: "AvenirNext-Bold", size: 14)
        static let Bold_15 = UIFont(name: "AvenirNext-Bold", size: 15)
        static let Bold_16 = UIFont(name: "AvenirNext-Bold", size: 16)
        static let Bold_17 = UIFont(name: "AvenirNext-Bold", size: 17)
        static let Bold_18 = UIFont(name: "AvenirNext-Bold", size: 18)
        static let Bold_20 = UIFont(name: "AvenirNext-Bold", size: 20)
        static let Bold_24 = UIFont(name: "AvenirNext-Bold", size: 24)
        static let Bold_28 = UIFont(name: "AvenirNext-Bold", size: 28)
        
        static let BoldItalic_14 = UIFont(name: "AvenirNext-BoldItalic", size: 14)
        static let BoldItalic_15 = UIFont(name: "AvenirNext-BoldItalic", size: 15)
        static let BoldItalic_16 = UIFont(name: "AvenirNext-BoldItalic", size: 16)
        static let BoldItalic_17 = UIFont(name: "AvenirNext-BoldItalic", size: 17)
        static let BoldItalic_18 = UIFont(name: "AvenirNext-BoldItalic", size: 18)
        static let BoldItalic_20 = UIFont(name: "AvenirNext-BoldItalic", size: 20)
        static let BoldItalic_24 = UIFont(name: "AvenirNext-BoldItalic", size: 24)
        static let BoldItalic_28 = UIFont(name: "AvenirNext-BoldItalic", size: 28)
        
        static let Heavy_14 = UIFont(name: "AvenirNext-Heavy", size: 14)
        static let Heavy_15 = UIFont(name: "AvenirNext-Heavy", size: 15)
        static let Heavy_16 = UIFont(name: "AvenirNext-Heavy", size: 16)
        static let Heavy_17 = UIFont(name: "AvenirNext-Heavy", size: 17)
        static let Heavy_18 = UIFont(name: "AvenirNext-Heavy", size: 18)
        static let Heavy_20 = UIFont(name: "AvenirNext-Heavy", size: 20)
        static let Heavy_24 = UIFont(name: "AvenirNext-Heavy", size: 24)
        static let Heavy_28 = UIFont(name: "AvenirNext-Heavy", size: 28)
        
        static let HeavyItalic_14 = UIFont(name: "AvenirNext-HeavyItalic", size: 14)
        static let HeavyItalic_15 = UIFont(name: "AvenirNext-HeavyItalic", size: 15)
        static let HeavyItalic_16 = UIFont(name: "AvenirNext-HeavyItalic", size: 16)
        static let HeavyItalic_17 = UIFont(name: "AvenirNext-HeavyItalic", size: 17)
        static let HeavyItalic_18 = UIFont(name: "AvenirNext-HeavyItalic", size: 18)
        static let HeavyItalic_20 = UIFont(name: "AvenirNext-HeavyItalic", size: 20)
        static let HeavyItalic_24 = UIFont(name: "AvenirNext-HeavyItalic", size: 24)
        static let HeavyItalic_28 = UIFont(name: "AvenirNext-HeavyItalic", size: 28)
    }
    
    static let Avenir_Book_14 = UIFont(name: "Avenir-Book", size: 14)
    static let Avenir_Roman_14 = UIFont(name: "Avenir-Roman", size: 14)
    
    static let Avenir_Book_16 = UIFont(name: "Avenir-Book", size: 16)
    static let Avenir_Roman_16 = UIFont(name: "Avenir-Roman", size: 16)
    static let Avenir_Medium_16 = UIFont(name: "Avenir-Medium", size: 16)
    static let AvenirNext_Medium_16 = UIFont(name: "AvenirNext-Medium", size: 16)
    
    static let Avenir_Book_18 = UIFont(name: "Avenir-Book", size: 18)
    static let Avenir_Roman_18 = UIFont(name: "Avenir-Roman", size: 18)
    static let Avenir_Oblique_18 = UIFont(name: "Avenir-Oblique", size: 18)
    static let Avenir_BookOblique_18 = UIFont(name: "Avenir-BookOblique", size: 18)
    static let Avenir_Medium_18 = UIFont(name: "Avenir-Medium", size: 18)
    static let AvenirNext_Regular_18 = UIFont(name: "AvenirNext-Regular", size: 18)
    static let AvenirNext_Medium_18 = UIFont(name: "AvenirNext-Medium", size: 18)
    
    static let Avenir_Medium_20 = UIFont(name: "Avenir-Medium", size: 20)
    static let AvenirNext_Regular_20 = UIFont(name: "AvenirNext-Regular", size: 20)
    static let HelveticaNeue_Bold_20 = UIFont(name: "HelveticaNeue-Bold", size: 20)
    
    static let Avenir_Medium_24 = UIFont(name: "Avenir-Medium", size: 24)
    static let Arial_BoldMT_24 = UIFont(name: "Arial-BoldMT", size: 24)
    
    static let AvenirNext_Medium_30 = UIFont(name: "AvenirNext-Medium", size: 30)
    static let Arial_BoldMT_30 = UIFont(name: "Arial-BoldMT", size: 30)
    static let HelveticaNeue_Bold_30 = UIFont(name: "HelveticaNeue-Bold", size: 30)
    
}
