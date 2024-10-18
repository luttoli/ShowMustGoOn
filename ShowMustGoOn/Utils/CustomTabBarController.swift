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
        
        let listVC = ListViewController() // 탭바에 표시할 VC 생성
        let listTabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet.clipboard.fill"), tag: 0) // 표시할 항목
        let listNaviController = UINavigationController(rootViewController: listVC) // 네비게이션 컨트롤러로 감싸주기
        listNaviController.tabBarItem = listTabBarItem
        
        let stepVC = StepViewController()
        let stepTabBarItem = UITabBarItem(title: "Step", image: UIImage(systemName: "figure.stair.stepper"), tag: 1)
        let stepNaviController = UINavigationController(rootViewController: stepVC)
        stepNaviController.tabBarItem = stepTabBarItem
        
        self.viewControllers = [listNaviController, stepNaviController]
        
        self.tabBar.barTintColor = .background.white // 투명한 배경을 가진 탭바의 배경 색상 설정
        self.tabBar.backgroundColor = .background.white // iOS 15 이상부터 명확하게 적용
        self.tabBar.tintColor = .tabBar.black // 선택된 항목 색상
        self.tabBar.unselectedItemTintColor = .tabBar.lightGray // 선택되지 않은 항목 색상
        self.selectedIndex = 0 // 기본 선택 인덱스 첫번째
    }
}
