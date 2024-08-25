//
//  BalanceViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit
import SwiftQRCodeScanner

class BalanceViewController: BaseViewController<BalanceViewModel>, SideMenuItemContent {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let address = "0x8FFE4DD9d2B6494F6173C4417Ad22134868987DE"
        
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
    
    lazy var naviView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var menu: UIButton = {
        let button = UIButton()
        button.setTitle("Balance", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleSide), for: .touchUpInside)
        return button
    }()
    
    lazy var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        button.addTarget(self, action: #selector(handleScan), for: .touchUpInside)
        return button
    }()
    
    let avatarView: JazziconImageView = {
        let view = JazziconImageView()
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        return view
    }()
    
    lazy var sendButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Send", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return view
    }()
    
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
        view.addConstts(format: "V:|-184-[v0]|", views: tableView)
        
        view.addSubview(naviView)
        view.addConstts(format: "H:|[v0]|", views: naviView)
        view.addConstts(format: "V:|[v0(84)]", views: naviView)
        
        view.addSubview(avatarView)
        view.addConstts(format: "H:[v0(80)]", views: avatarView)
        view.addConstts(format: "V:[v0(80)]", views: avatarView)
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(sendButton)
        view.addConstts(format: "H:|-20-[v0(80)]", views: sendButton)
        view.addConstts(format: "V:[v0(40)]", views: sendButton)
        sendButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor).isActive = true
        
        naviView.addSubview(menu)
        naviView.addConstts(format: "H:|-10-[v0]", views: menu)
        naviView.addConstts(format: "V:[v0]|", views: menu)
        
        naviView.addSubview(scanButton)
        naviView.addConstts(format: "H:[v0]-15-|", views: scanButton)
        naviView.addConstts(format: "V:[v0]|", views: scanButton)
    }
    
    // MARK: - Method
    
    @objc func handleSide() {
        showSideMenu()
    }
    
    @objc func handleSend() {
        print("Here we go")
        
        let receiver = "0xD0f9482e1163587CD0793DABad03Bf74bA5AB0ab"
        let sendTxViewModel = SendTxViewModel()
        
        sendTxViewModel.sendEther(address: receiver, value: 0.001) {
            
        }
    }
    
    @objc func handleScan() {
        let scanner = QRCodeScannerController()
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    
    func handleAddress(_ result: String) {
        let hexSeed = result.suffix(8)
        guard let decimalSeed = Int(hexSeed, radix: 16) else { return }
        
        avatarView.seed = UInt32(decimalSeed)
    }
    
}

extension BalanceViewController: QRScannerCodeDelegate {
    
    func qrScanner(_ controller: UIViewController, didScanQRCodeWithResult result: String) {
        print(result)
        
        handleAddress(result)
    }
    
    func qrScanner(_ controller: UIViewController, didFailWithError error: SwiftQRCodeScanner.QRCodeError) {
        print(error.localizedDescription)
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print(#function)
    }
    
}

class BalanceViewTableView: BaseTableView, UITableViewDataSource, UITableViewDelegate {
    
    weak var controller: BalanceViewController!
    weak var viewModel: BalanceViewModel!
    
    // MARK: - View
    
    var refresher: UIRefreshControl!
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        dataSource = self
        delegate = self
        
        register(BalanceViewTableCell.self)
        
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        addSubview(refresher)
    }
    
    // MARK: - Action
    
    @objc func handleRefresh() {
        
    }
    
    @objc func handleSide() {
        controller.handleSide()
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
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
