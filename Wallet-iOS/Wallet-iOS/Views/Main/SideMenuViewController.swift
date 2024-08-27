//
//  SideMenuViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class SideMenuViewController: MenuViewController {
    
    var viewModel: SideMenuViewModel?
    
    var selectedIndex = 0
    
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
    
    var selectedIndex = 0
    
    let appName: UILabel = {
        let view = UILabel()
        view.font = BSFont.Bold_32
        view.text = "Ethereum Wallet"
        view.sizeToFit()
        let gradientImage = UIImage.gradientImageWithBounds(bounds: view.bounds, colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor], direction: .zeroToOne)
        view.textColor = UIColor(patternImage: gradientImage)
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
        cell.isSelectedItem = selectedIndex == row
        
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
        
        selectedIndex = indexPath.row
        reloadData()
    }
    
}

class SideTableCell: BaseTableViewCell {
    
    var isSelectedItem = false
    
    override func layoutSubviews() {
        super.layoutSubviews()

        marker.gradientBackground(from: Colors.gradientBlueFrom, to: Colors.gradientBlueTo, direction: .zeroToOne)
        
        let gradientImage = UIImage.gradientImageWithBounds(bounds: itemLabel.bounds, colors: [Colors.gradientBlueFrom.cgColor, Colors.gradientBlueTo.cgColor], direction: .zeroToOne)

        if isSelectedItem {
            marker.isHidden = false
            itemLabel.textColor = UIColor(patternImage: gradientImage)
        } else {
            marker.isHidden = true
            itemLabel.textColor = Colors.label_primary
        }
    }
    
    let marker: UIView = {
        let view = UIView()
        return view
    }()
 
    let itemLabel: UILabel = {
        let label = UILabel()
        label.font = BSFont.Medium_28
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.separator
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_secondary
        
        addSubview(marker)
        addConstts(format: "H:|[v0(8)]", views: marker)
        addConstts(format: "V:|[v0]|", views: marker)
        
        addSubview(itemLabel)
        addConstts(format: "H:[v0]", views: itemLabel)
        addConstts(format: "V:[v0]", views: itemLabel)
        itemLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(separatorLine)
        addConstts(format: "H:|-10-[v0]|", views: separatorLine)
        addConstts(format: "V:[v0(0.5)]|", views: separatorLine)
    }
    
}
