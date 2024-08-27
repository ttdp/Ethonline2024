//
//  HostViewController.swift
//  Wallet-iOS
//
//  Created by Tian Tong on 2024/8/24.
//

import UIKit

class HostViewController: MenuContainerViewController {
    
    var viewModel: HostViewModel?

    var sideMenuViewController: SideMenuViewController?
    var balanceViewController: BalanceViewController?
    var nftViewController: NFTViewController?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)
        
        // Instantiate menu view controller by identifier
        self.menuViewController = sideMenuViewController
        
        // Gather content items controllers
        self.contentViewControllers = contentControllers()
        
        // Select initial content controller. It's needed even if the first view controller should be selected.
        self.selectContentViewController(contentViewControllers.first!)
        
        self.currentItemOptions.cornerRadius = 10.0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Options to customize menu transition animation.
        var options = TransitionOptions()
        
        // Animation duration
        options.duration = size.width < size.height ? 0.4 : 0.6
        
        // Part of item content remaining visible on right when menu is shown
        options.visibleContentWidth = size.width / 6
        self.transitionOptions = options
    }
    
    func showFirst() {
        self.selectContentViewController(contentViewControllers.first!)
    }
    
    private func contentControllers() -> [UIViewController] {
        guard let balance = balanceViewController, let nft = nftViewController else {
            return []
        }
        
        return [balance, nft]
    }
    
}
