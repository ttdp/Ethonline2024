//
//  Toast.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class ToastConfig {
    
    static var showTime: Double = 2.0
    static var appearDuration: Double = 0.2
    static var disappearDuration: Double = 0.3
    
//    static var successColor: UIColor = UIColor(hex: "#4BC84F")  // #3DBE61  // #EBF7EE
//    static var warningColor: UIColor = UIColor(hex: "#FFD454")  // #EF9404  // #FEF7EA
//    static var errorColor: UIColor = UIColor(hex: "#E8665F")    // #D8512F  // #FCEDEA
                                                                // #006DE6  // #E5EFFA  // Blue
    static var successBorderColor = UIColor(hex: "#3DBE61")
    static var warningBorderColor = UIColor(hex: "#EF9404")
    static var errorBorderColor = UIColor(hex: "#D8512F")
    
    static var successBackgroundColor = UIColor(hex: "#EBF7EE")
    static var warningbackgroundColor = UIColor(hex: "#FEF7EA")
    static var errorBackgroundColor = UIColor(hex: "#FCEDEA")
    
}

enum ToastType: String {
    case success
    case warning
    case error

    var image: UIImage? {
        switch self {
        case .success:
            return Images.toast_success
        case .warning:
            return Images.toast_warning
        case .error:
            return Images.toast_error
        }
    }
    
    var borderColor: UIColor? {
        switch self {
        case .success:
            return ToastConfig.successBorderColor
        case .warning:
            return ToastConfig.warningBorderColor
        case .error:
            return ToastConfig.errorBorderColor
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .success:
            return ToastConfig.successBackgroundColor
        case .warning:
            return ToastConfig.warningbackgroundColor
        case .error:
            return ToastConfig.errorBackgroundColor
        }
    }
    
}

class Toast: UIView {
    
    let title: String
    let type: ToastType
    
    public init(title: String, type: ToastType) {
        self.title = title
        self.type = type
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    // MARK: - View
    
    let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.alpha = 0.95
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalCentering
        view.spacing = 10
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = BSFont.secondary
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        let width = UIScreen.main.bounds.width
        
        addSubview(contentView)
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = type.borderColor?.cgColor
        contentView.backgroundColor = type.backgroundColor
        addConstts(format: "H:|-10-[v0(\(width - 20))]-10-|", views: contentView)
        addConstts(format: "V:|-(-44)-[v0(50)]|", views: contentView)
        
//        addSubview(stackView)
//        addConstts(format: "V:|-(-44)-[v0(44)]|", views: stackView)
//        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20).isActive = true
//        stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20).isActive = true
        
//        iconView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh + 1, for: .horizontal)
//        iconView.image = type.image
//        stackView.addArrangedSubview(iconView)
//
//        titleLabel.text = title
//        stackView.addArrangedSubview(titleLabel)
        
        imageView.image = type.image
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addConstts(format: "H:|-10-[v0(30)]", views: imageView)
        contentView.addConstts(format: "V:|-10-[v0(30)]-10-|", views: imageView)
        
        titleLabel.text = title
        contentView.addConstts(format: "H:|-50-[v0]-10-|", views: titleLabel)
        contentView.addConstts(format: "V:|[v0]|", views: titleLabel)
    }
    
    func show() {        
        let windowSence = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegaet = windowSence?.delegate as? SceneDelegate
        sceneDelegaet?.window?.addSubview(self)
        
        let y: CGFloat = Screen.hasTopNotch ? 104 : 64
        UIView.animate(withDuration: ToastConfig.appearDuration, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: y)
        }) { _ in
            UIView.animate(withDuration: ToastConfig.disappearDuration, delay: ToastConfig.showTime, animations: {
                self.transform = CGAffineTransform(translationX: 0, y: -y)
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
    
    class func dev(_ message: String) {
        let identifier = Bundle.main.bundleIdentifier
        let isDev = identifier?.hasSuffix(".dev") ?? false

        guard isDev else { return }
        
        DispatchQueue.main.async {
            let toast = Toast(title: message, type: .error)
            let windowSence = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegaet = windowSence?.delegate as? SceneDelegate
            sceneDelegaet?.window?.addSubview(toast)
            
            let y: CGFloat = Screen.hasTopNotch ? 88 + 51 : 64 + 51
            UIView.animate(withDuration: ToastConfig.appearDuration, animations: {
                toast.transform = CGAffineTransform(translationX: 0, y: y)
            }) { _ in
                UIView.animate(withDuration: ToastConfig.disappearDuration, delay: ToastConfig.showTime, animations: {
                    toast.transform = CGAffineTransform(translationX: 0, y: -y)
                }) { _ in
                    toast.removeFromSuperview()
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

