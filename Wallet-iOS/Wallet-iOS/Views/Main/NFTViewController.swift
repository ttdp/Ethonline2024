//
//  NFTViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class NFTViewController: BaseViewController<NFTViewModel>, SideMenuItemContent {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var tableView: NFTViewTableView = {
        let tableView = NFTViewTableView(frame: .zero, style: .insetGrouped)
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
    
    @objc func handleSide() {
        showSideMenu()
    }
    
}

class NFTViewTableView: BaseTableView, UITableViewDataSource, UITableViewDelegate {
    
    weak var controller: NFTViewController!
    weak var viewModel: NFTViewModel!
    
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
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "NFT"
        view.font = BSFont.Medium_28
        view.sizeToFit()
        let gradientImage = UIImage.gradientImageWithBounds(bounds: view.bounds, colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor], direction: .zeroToOne)
        view.textColor = UIColor(patternImage: gradientImage)
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        dataSource = self
        delegate = self
        
        register(NFTViewTableCell.self)
    }
    
    // MARK: - Action
    
    @objc func handleSide() {
        controller.handleSide()
    }
    
    // MARK: - TableView DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(at: indexPath) as NFTViewTableCell
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

        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}

class NFTViewTableCell: BaseTableViewCell {
    
    let nftImage: UIImageView = {
        let view = UIImageView()
        view.image = Images.BigHugs
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func setUpViews() {
        contentView.addSubview(nftImage)
        contentView.addConstts(format: "H:|[v0]|", views: nftImage)
        let size = Int(Screen.width - 40)
        contentView.addConstts(format: "V:|[v0(\(size))]|", views: nftImage)
    }
    
}
