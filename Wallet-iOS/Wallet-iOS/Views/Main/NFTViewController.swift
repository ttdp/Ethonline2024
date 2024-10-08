//
//  NFTViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit
import Kingfisher

class NFTViewController: BaseViewController<NFTViewModel>, SideMenuItemContent {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getNFTs(for: testAddress) {
            self.tableView.reloadData()
        }
    }
    
    lazy var tableView: NFTViewTableView = {
        let tableView = NFTViewTableView(frame: .zero, style: .grouped)
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
        view.font = Fonts.Medium_28
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
        return viewModel.nfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(at: indexPath) as NFTViewTableCell
        let nft = viewModel.nfts[indexPath.row]
        
        cell.nftLabel.text = nft.title
        if let gateway = nft.media?.first?.gateway {
            let url = URL(string: gateway)
            cell.nftImage.kf.setImage(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.addSubview(menuButton)
        view.addConstts(format: "H:|-14-[v0(44)]", views: menuButton)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientView.animateGradient()
    }
    
    let nftLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.Medium_28
        return label
    }()
    
    let gradientView: GradientBorderView = {
        let view = GradientBorderView()
        view.layer.cornerRadius = 10
        return view
    }()

    let nftImage: UIImageView = {
        let view = UIImageView()
        view.image = Images.BigHugs
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        
        addSubview(nftLabel)
        addConstts(format: "H:[v0]", views: nftLabel)
        addConstts(format: "V:|[v0]", views: nftLabel)
        nftLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(gradientView)
        let height = Screen.width - 120
        addConstts(format: "H:[v0(\(height))]", views: gradientView)
        addConstts(format: "V:|-45-[v0(\(height))]-35-|", views: gradientView)
        gradientView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        gradientView.addSubview(nftImage)
        gradientView.addConstts(format: "H:|-5-[v0]-5-|", views: nftImage)
        gradientView.addConstts(format: "V:|-5-[v0]-5-|", views: nftImage)
        gradientView.animateGradient()
    }

}
