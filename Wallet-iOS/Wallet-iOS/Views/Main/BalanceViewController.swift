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
        
        viewModel.getEthereumMainnet(for: address)
        viewModel.getEthereumSepholia(for: address)
        viewModel.getArtibrumMainnet(for: address)
        viewModel.getArtibrumSepholia(for: address)
        viewModel.getOptimismMainnet(for: address)
        viewModel.getOptimismSepholia(for: address)
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
    
    let balanceLabel: UILabel = {
        let view = UILabel()
        view.text = "Ethereum: "
        return view
    }()

    let balanceValue: UILabel = {
        let view = UILabel()
        view.text = "0 ETH"
        return view
    }()
    
    lazy var tableView: BalanceViewTableView = {
        let tableView = BalanceViewTableView(frame: .zero, style: .grouped)
        tableView.controller = self
        tableView.viewModel = self.viewModel
        return tableView
    }()
    
    override func setUpViews() {
        view.addSubview(tableView)
        view.addConstts(format: "H:|[v0]|", views: tableView)
        view.addConstts(format: "V:|-284-[v0]|", views: tableView)
        
        view.addSubview(naviView)
        view.addConstts(format: "H:|[v0]|", views: naviView)
        view.addConstts(format: "V:|[v0(84)]", views: naviView)
        
        view.addSubview(avatarView)
        view.addConstts(format: "H:[v0(80)]", views: avatarView)
        view.addConstts(format: "V:[v0(80)]", views: avatarView)
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarView.topAnchor.constraint(equalTo: naviView.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(balanceLabel)
        view.addSubview(balanceValue)
        view.addConstts(format: "H:|-15-[v0]-10-[v1]", views: balanceLabel, balanceValue)
        balanceLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20).isActive = true
        balanceValue.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor).isActive = true
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(at: indexPath) as BalanceViewTableCell
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
    
    let blankView: BlankView = {
        let view = BlankView()
        return view
    }()
    
    override func setUpViews() {
        contentView.addSubview(blankView)
        contentView.addConstts(format: "H:|[v0]|", views: blankView)
        let size = Int(Screen.imageHeightPadding_15 * 2 / 3)
        contentView.addConstts(format: "V:|[v0(\(size))]|", views: blankView)
    }
    
}
