//
//  BalanceViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class BalanceViewController: BaseViewController<BalanceViewModel>, SideMenuItemContent {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    lazy var tableView: BalanceViewTableView = {
        let tableView = BalanceViewTableView(frame: .zero, style: .grouped)
        tableView.controller = self
        tableView.viewModel = self.viewModel
        return tableView
    }()
    
    override func setUpViews() {
        view.addSubview(tableView)
        view.addConstts(format: "H:|[v0]|", views: tableView)
        view.addConstts(format: "V:|-84-[v0]|", views: tableView)
        
        view.addSubview(naviView)
        view.addConstts(format: "H:|[v0]|", views: naviView)
        view.addConstts(format: "V:|[v0(84)]", views: naviView)
        
        naviView.addSubview(menu)
        naviView.addConstts(format: "H:|-10-[v0]", views: menu)
        naviView.addConstts(format: "V:[v0]|", views: menu)
    }
    
    // MARK: - Method
    
    @objc func handleSide() {
        showSideMenu()
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
