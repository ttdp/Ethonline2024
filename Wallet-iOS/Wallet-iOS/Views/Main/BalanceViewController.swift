//
//  BalanceViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit
import SwiftQRCodeScanner

let testAddress = "0x8FFE4DD9d2B6494F6173C4417Ad22134868987DE"

class BalanceViewController: BaseViewController<BalanceViewModel>, SideMenuItemContent {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTokenPrice()
        loadTokenBalance(address: testAddress)

        Task {
            await AuthManager.shared.setup()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAuthState), name: .authState, object: nil)
    }
    
    lazy var tableView: BalanceViewTableView = {
        let tableView = BalanceViewTableView(frame: .zero, style: .insetGrouped)
        tableView.controller = self
        tableView.viewModel = self.viewModel
        return tableView
    }()
    
    override func setUpViews() {
        view.backgroundColor = Colors.groupedBackground_primary
        
        view.addSubview(tableView)
        view.addConstts(format: "H:|[v0]|", views: tableView)
        view.addConstts(format: "V:|[v0]|", views: tableView)
    }
    
    // MARK: - Method
    
    func loadTokenPrice() {
        viewModel.getEthereumPrice {
            self.tableView.reloadData()
        }
        
        viewModel.getArbitrumPrice {
            self.tableView.reloadData()
        }
        
        viewModel.getOptimismPrice {
            self.tableView.reloadData()
        }
    }
    
    func loadTokenBalance(address: String) {
        viewModel.getEthereumMainnet(for: address) {
            self.tableView.reloadData()
        }
        
        viewModel.getEthereumSepholia(for: address) {
            self.tableView.reloadData()
        }
        
        viewModel.getArtibrumMainnet(for: address) {
            self.tableView.reloadData()
        }
        
        viewModel.getArtibrumSepholia(for: address) {
            self.tableView.reloadData()
        }
        
        viewModel.getOptimismMainnet(for: address) {
            self.tableView.reloadData()
        }
        
        viewModel.getOptimismSepholia(for: address) {
            self.tableView.reloadData()
        }
    }
    
    @objc func handleSide() {
        showSideMenu()
    }
    
    @objc func handleAuthState(notification: Notification) {
        if let address = notification.object as? String {
            tableView.updateAvatar(address)
            tableView.addressLabel.text = address
            tableView.authButton.isHidden = true

            loadTokenBalance(address: address)
        } else {
            tableView.authButton.isHidden = false
        }
    }
    
}

class BalanceViewTableView: BaseTableView, UITableViewDataSource, UITableViewDelegate, QRScannerCodeDelegate {
    
    weak var controller: BalanceViewController!
    weak var viewModel: BalanceViewModel!
    
    // MARK: - View
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        let image = Images.MenuIcon!
        let gradientImage = image.drawLinearGradient(
            colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor],
                direction: .zeroToOne)
        button.setImage(gradientImage, for: .normal)
        button.addTarget(self, action: #selector(handleSide), for: .touchUpInside)
        return button
    }()
    
    lazy var scanButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold)
        let image = UIImage(systemName: "qrcode.viewfinder", withConfiguration: config)!
        let gradientImage = image.drawLinearGradient(
                colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor],
                direction: .oneZeroToZeroOne)
        button.setImage(gradientImage, for: .normal)
        button.addTarget(self, action: #selector(handleScan), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Balance"
        view.font = BSFont.Medium_28
        view.sizeToFit()
        let gradientImage = UIImage.gradientImageWithBounds(bounds: view.bounds, colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor], direction: .zeroToOne)
        view.textColor = UIColor(patternImage: gradientImage)
        return view
    }()
    
    let avatarView: JazziconImageView = {
        let view = JazziconImageView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    
    let addressLabel: UILabel = {
        let view = UILabel()
        view.font = BSFont.label
        view.textColor = Colors.label_secondary
        view.text = testAddress
        return view
    }()
    
    lazy var authButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Auth", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.addTarget(self, action: #selector(handleAuth), for: .touchUpInside)
        return view
    }()
    
    lazy var userButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("User", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.addTarget(self, action: #selector(handleUser), for: .touchUpInside)
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        dataSource = self
        delegate = self
        
        register(BalanceViewTableCell.self)
    }
    
    // MARK: - Action
    
    @objc func handleSide() {
        controller.handleSide()
    }
    
    @objc func handleScan() {
        let scanner = QRCodeScannerController()
        scanner.delegate = self
        controller.present(scanner, animated: true, completion: nil)
    }
    
    @objc func handleAuth() {
        viewModel.showAuth()
    }

    @objc func handleUser() {
        viewModel.showUser { hasUser in
            if !hasUser {
                self.warning("No auth user found.")
            }
        }
    }
    
    // MARK: - Method
    
    func updateAvatar(_ address: String) {
        let hexSeed = address.suffix(8)
        guard let decimalSeed = Int(hexSeed, radix: 16) else { return }
        
        avatarView.seed = UInt32(decimalSeed)
    }
    
    // MARK: - QRScannerCode Delegate
    
    func qrScanner(_ controller: UIViewController, didScanQRCodeWithResult result: String) {
        updateAvatar(result)
    }
    
    func qrScanner(_ controller: UIViewController, didFailWithError error: SwiftQRCodeScanner.QRCodeError) {
        print(error.localizedDescription)
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print(#function)
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.balances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(at: indexPath) as BalanceViewTableCell
        let token = viewModel.balances[indexPath.row]
        
        cell.tokenIcon.image = token.icon
        cell.tokenName.text = token.name
        cell.tokenPrice.text = token.formattedPrice
        cell.tokenChange .text = token.changeSinceLast15Minutes
        cell.balanceValue.text = token.formattedBalance
        cell.balancePrice.text = token.ballanceValue
        
        if token.changeSinceLast15Minutes?.hasPrefix("+") ?? false {
            cell.tokenChange.textColor = .systemGreen
        } else {
            cell.tokenChange.textColor = .systemRed
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.addSubview(menuButton)
        view.addConstts(format: "H:|-(-6)-[v0(44)]", views: menuButton)
        view.addConstts(format: "V:|[v0(44)]", views: menuButton)
        
        view.addSubview(titleLabel)
        view.addConstts(format: "H:[v0]", views: titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor).isActive = true
        
        view.addSubview(scanButton)
        view.addConstts(format: "H:[v0(44)]-(-6)-|", views: scanButton)
        view.addConstts(format: "V:|[v0(44)]", views: scanButton)
        
        view.addSubview(avatarView)
        view.addConstts(format: "H:[v0(80)]", views: avatarView)
        view.addConstts(format: "V:|-60-[v0(80)]", views: avatarView)
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(addressLabel)
        view.addConstts(format: "H:[v0]", views: addressLabel)
        addressLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 5).isActive = true
        addressLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor).isActive = true
        
        view.addSubview(authButton)
        view.addConstts(format: "H:|[v0(80)]", views: authButton)
        view.addConstts(format: "V:[v0(40)]", views: authButton)
        authButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor).isActive = true
        
        view.addSubview(userButton)
        view.addConstts(format: "H:[v0(80)]|", views: userButton)
        view.addConstts(format: "V:[v0(40)]", views: userButton)
        userButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
}

class BalanceViewTableCell: BaseTableViewCell {
    
    let layerView: BaseView = {
        let view = BaseView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let tokenIcon: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    let tokenName: UILabel = {
        let view = UILabel()
        view.font = BSFont.Medium_22
        view.textColor = Colors.label_primary
        return view
    }()
    
    let tokenPrice: UILabel = {
        let view = UILabel()
        view.font = BSFont.label
        view.textColor = Colors.label_secondary
        return view
    }()
    
    let tokenChange: UILabel = {
        let view = UILabel()
        view.font = BSFont.label
        return view
    }()
    
    let balanceValue: UILabel = {
        let view = UILabel()
        view.font = BSFont.Medium_22
        view.textColor = Colors.label_primary
        return view
    }()
    
    let balancePrice: UILabel = {
        let view = UILabel()
        view.font = BSFont.label
        view.textColor = Colors.label_secondary
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        
        contentView.addSubview(layerView)
        contentView.addConstts(format: "H:|[v0]|", views: layerView)
        contentView.addConstts(format: "V:|-20-[v0(80)]|", views: layerView)
        
        contentView.addSubview(tokenIcon)
        contentView.addConstts(format: "H:|-15-[v0(60)]", views: tokenIcon)
        contentView.addConstts(format: "V:|-30-[v0(60)]-10-|", views: tokenIcon)
        
        contentView.addSubview(tokenName)
        contentView.addConstts(format: "H:|-90-[v0]", views: tokenName)
        contentView.addConstts(format: "V:|-35-[v0]", views: tokenName)
        
        contentView.addSubview(tokenPrice)
        contentView.addConstts(format: "H:|-90-[v0]", views: tokenPrice)
        contentView.addConstts(format: "V:|-65-[v0]", views: tokenPrice)
        
        contentView.addSubview(tokenChange)
        contentView.addConstts(format: "V:|-65-[v0]", views: tokenChange)
        tokenChange.leadingAnchor.constraint(equalTo: tokenPrice.trailingAnchor, constant: 10).isActive = true
        
        contentView.addSubview(balanceValue)
        contentView.addConstts(format: "H:[v0]-10-|", views: balanceValue)
        contentView.addConstts(format: "V:|-35-[v0]", views: balanceValue)
        
        contentView.addSubview(balancePrice)
        contentView.addConstts(format: "H:[v0]-10-|", views: balancePrice)
        contentView.addConstts(format: "V:|-65-[v0]", views: balancePrice)
    }
    
}
