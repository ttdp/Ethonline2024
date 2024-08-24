//
//  JazziconImageView.swift
//  Wallet-iOS
//
//  Created by TIAN TONG on 8/24/24.
//

#if os(iOS)

import UIKit

open class JazziconImageView: UIView {
    
    override init(frame: CGRect) {
        self.seed = 1
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var seed: UInt32 {
        willSet {
            setNeedsDisplay()
        }
    }

    // MARK: Override Draw
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let jazzicon = Jazzicon(seed: seed)
        jazzicon.draw(with: context, in: rect)
    }
}
    
#endif
