//
//  UIImage+Extension.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/27/24.
//

import UIKit

extension UIImage {
    
    func drawLinearGradient(colors: [CGColor], direction: GradientDirection) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        
        let xZero: CGFloat = 0
        let xHalf: CGFloat = self.size.width / 2
        let xOne: CGFloat = self.size.width
        
        let yZero: CGFloat = 0
        let yHalf: CGFloat = self.size.height / 2
        let yOne: CGFloat = self.size.height
        
        let startPoint: CGPoint
        let endPoint: CGPoint
        
        switch direction {
        case .leftToRight:
            startPoint = CGPoint(x: xZero, y: yHalf)
            endPoint = CGPoint(x: xOne, y: yHalf)
        case .rightToLeft:
            startPoint = CGPoint(x: xOne, y: yHalf)
            endPoint = CGPoint(x: xZero, y: yHalf)
        case .upToDown:
            startPoint = CGPoint(x: xHalf, y: yOne)
            endPoint = CGPoint(x: xHalf, y: yZero)
        case .downToUp:
            startPoint = CGPoint(x: xHalf, y: yZero)
            endPoint = CGPoint(x: xHalf, y: yOne)
        case .zeroToOne:
            startPoint = CGPoint(x: xZero, y: yOne)
            endPoint = CGPoint(x: xOne, y: yZero)
        case .oneToZero:
            startPoint = CGPoint(x: xOne, y: yZero)
            endPoint = CGPoint(x: xZero, y: yOne)
        case .zeroOneToOneZero:
            startPoint = CGPoint(x: xZero, y: yZero)
            endPoint = CGPoint(x: xOne, y: yOne)
        case .oneZeroToZeroOne:
            startPoint = CGPoint(x: xOne, y: yOne)
            endPoint = CGPoint(x: xZero, y: yZero)
        }
        
        var shouldReturnNil = false
        let gradientImage = renderer.image { context in
            context.cgContext.translateBy(x: 0, y: self.size.height)
            context.cgContext.scaleBy(x: 1.0, y: -1.0)

            context.cgContext.setBlendMode(.normal)
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

            // Create gradient
            let colors = colors as CFArray
            let colorsSpace = CGColorSpaceCreateDeviceRGB()
            
            guard let gradient = CGGradient(colorsSpace: colorsSpace, colors: colors, locations: nil) else {
                shouldReturnNil = true
                return
            }

            // Apply gradient
            guard let cgImage = self.cgImage else {
                shouldReturnNil = true
                print("Couldn't get cgImage of UIImage.")
                return
            }
            
            context.cgContext.clip(to: rect, mask: cgImage)
            context.cgContext.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: .init(rawValue: 0)
            )
        }

        return shouldReturnNil ? nil : gradientImage
    }
    
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor], direction: GradientDirection) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        case .upToDown:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .downToUp:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        case .zeroToOne:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        case .oneToZero:
            gradientLayer.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        case .zeroOneToOneZero:
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        case .oneZeroToZeroOne:
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

enum GradientDirection {
    case leftToRight
    case upToDown
    case downToUp
    case rightToLeft
    case zeroToOne
    case oneToZero
    case zeroOneToOneZero
    case oneZeroToZeroOne
}
