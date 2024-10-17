//
//  CustomTabBarController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listVC = ListViewController()
        let listTabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet.clipboard.fill"), tag: 0)
        let listNaviController = UINavigationController(rootViewController: listVC)
        listNaviController.tabBarItem = listTabBarItem
        
        self.viewControllers = [listNaviController]
        
        self.tabBar.barTintColor = .background.white
        self.tabBar.unselectedItemTintColor = .text.subDarkGray
        self.tabBar.tintColor = .tabbar.darkGray
        
        self.selectedIndex = 0
    }
}
