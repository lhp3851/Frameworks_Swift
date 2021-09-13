//
//  BaseTabBarViewController.swift
//  WeSeenSwift
//
//  Created by Jerry on 2021/7/17.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    
    lazy var homeNavigator:BaseNavigationViewController = {
        let vc: HomeViewController = HomeViewController()
        let temp = BaseNavigationViewController(rootViewController: vc)
        temp.tabBarItem.title = "首页"
        return temp
    }()
    
    lazy var librariesNavigator:BaseNavigationViewController = {
        let vc: LibrariesViewController = LibrariesViewController()
        let temp = BaseNavigationViewController(rootViewController: vc)
        temp.tabBarItem.title = "实验室"
        return temp
    }()
    
    lazy var settingsNavigator:BaseNavigationViewController = {
        let vc: SettingsViewController = SettingsViewController()
        let temp = BaseNavigationViewController(rootViewController: vc)
        temp.tabBarItem.title = "设置"
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        
    }
    
    func setupViewControllers()  {
        let vcs = [homeNavigator, librariesNavigator, settingsNavigator];
        setViewControllers(vcs, animated: true)
    }
  

}
