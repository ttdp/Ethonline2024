//
//  SideMenuViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class SideMenuViewController: MenuViewController {
    
    var viewModel: SideMenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    // MARK: - View

    lazy var tableView: SideTableView = {
        let view = SideTableView(frame: .zero, style: .grouped)
        view.controller = self
        return view
    }()

    func setUpViews() {
        view.backgroundColor = Colors.groupedBackground_primary
        
        view.addSubview(tableView)
        view.addConstts(format: "H:|[v0]|", views: tableView)
        view.addConstts(format: "V:|[v0]", views: tableView)
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Method
    
    func showController(at indexPath: IndexPath) {
        guard let hostViewController = self.menuContainerViewController else {
            return
        }

        hostViewController.selectContentViewController(hostViewController.contentViewControllers[indexPath.row])
        hostViewController.hideSideMenu()
    }
    
}

class SideTableView: BaseTableView, UITableViewDataSource, UITableViewDelegate {
    
    var controller: SideMenuViewController?
    
    let appName: UILabel = {
        let view = UILabel()
        view.font = BSFont.Medium_30
        view.text = "Ethereum Wallet"
        view.sizeToFit()
        let gradientImage = UIImage.gradientImageWithBounds(bounds: view.bounds, colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor], direction: .zeroToOne)
        view.textColor = UIColor.init(patternImage: gradientImage)
        return view
    }()
    
    let verison: UILabel = {
        let view = UILabel()
        view.font = BSFont.label
        view.text = "Version 0.01"
        view.textColor = Colors.label_secondary
        return view
    }()
    
    lazy var walletIcon: UIImageView = {
        let view = UIImageView()
        let image = Images.Ethereum!
        let gradientImage = image.drawLinearGradient(
            colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor],
                direction: .zeroToOne)
        view.image = gradientImage
        return view
    }()
    
    lazy var avatarHeader: UIView = {
        let view = UIView()
        view.addSubview(appName)
        view.addConstts(format: "V:|-20-[v0]", views: appName)
        appName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(walletIcon)
        view.addConstts(format: "H:[v0(160)]", views: walletIcon)
        view.addConstts(format: "V:|-80-[v0(160)]-60-|", views: walletIcon)
        walletIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(verison)
        view.addConstts(format: "V:[v0]-15-|", views: verison)
        verison.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        delegate = self
        dataSource = self
        
        register(SideTableCell.self)
    }
    
    // MARK: - DataSource & Delegate
    
    let items = ["Balance", "NFT"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
    
        let cell = tableView.dequeueReusable(at: indexPath) as SideTableCell
        cell.itemLabel.text = item
        
        if row == items.count - 1 {
            cell.separatorLine.isHidden = true
        } else {
            cell.separatorLine.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return avatarHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller?.showController(at: indexPath)
    }
    
}

class SideTableCell: BaseTableViewCell {
 
    var itemLabel: UILabel = {
        let label = UILabel()
        label.font = BSFont.Medium_24
        label.textColor = Colors.label_primary
        return label
    }()
    
    var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separator
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_secondary
        
        addSubview(itemLabel)
        addConstts(format: "H:[v0]", views: itemLabel)
        itemLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addConstts(format: "V:|[v0]|", views: itemLabel)
        
        addSubview(separatorLine)
        addConstts(format: "H:|-20-[v0]|", views: separatorLine)
        addConstts(format: "V:[v0(0.5)]|", views: separatorLine)
    }
    
}
