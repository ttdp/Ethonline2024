//
//  UIButton+Extension.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

extension UIButton {
 
    func addRightImage(image: UIImage?, offset: CGFloat) {
        setImage(image, for: .normal)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
    }
    
}

extension UIButton {
    
    func addAnimation() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        alpha = 0.85
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        alpha = 1.0
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
                       }, completion: nil)
    }
    
}

extension UIButton {
    
    func showIndicator(color: UIColor = .white) {
        let tag = 10301
        self.isEnabled = false
        self.setTitle("", for: .normal)

        let indicator = UIActivityIndicatorView()
        indicator.tag = tag
        indicator.color = color
        indicator.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        indicator.startAnimating()
        self.addSubview(indicator)
    }
    
    func hideIndicator(title: String) {
        let tag = 10301
        self.isEnabled = true
        self.setTitle(title, for: .normal)
        
        if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
    
}
