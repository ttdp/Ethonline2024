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
    
    @objc func updateAvatar(notification: Notification) {
//        guard let avatarURL = notification.object as? String else {
//            return
//        }
        
//        let url = URL(string: SERVER_BASE + avatarURL)
//
//        tableView.avatarView.kf.setImage(with: url, options: [.forceRefresh])
    }
    
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
    
    lazy var avatarView: UIImageView = {
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 66
        avatar.layer.masksToBounds = true
//        let avatarURL = Default.getUser()?.avatar ?? ""
//        let url = URL(string: SERVER_BASE + avatarURL)
//        
//        let pngSerializer = FormatIndicatedCacheSerializer.png
//        avatar.kf.indicatorType = .activity
//        avatar.kf.setImage(with: url, placeholder: Images.avatar_default, options: [.cacheSerializer(pngSerializer)])
        return avatar
    }()
    
    lazy var avatarHeader: UIView = {
        let view = UIView()
        view.addSubview(avatarView)
        view.addConstts(format: "H:[v0(132)]", views: avatarView)
        view.addConstts(format: "V:|-34-[v0(132)]-34-|", views: avatarView)
        avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    override func setUpViews() {
        backgroundColor = Colors.groupedBackground_primary
        delegate = self
        dataSource = self
        
        register(SideTableCell.self)
    }
    
    // MARK: - DataSource & Delegate
    
    let items = ["Balance", "NFT", "Transactions", "Settings"]
    
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
        cell.separatorLine.isHidden = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return avatarHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
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
        label.font = BSFont.secondaryMedium
        label.textColor = Colors.label_secondary
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
