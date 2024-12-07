//
//  RxViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/3/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxTableViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
    lazy var rxButtonPage: UIBarButtonItem = {
        let allCancelButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(goRxButtonPage))
        return allCancelButton
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension RxTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        
        
        
    }
}

// MARK: - Navigation
extension RxTableViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "RxSwift Practice", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
        
        navigationItem.rightBarButtonItem = rxButtonPage
        navigationController?.navigationBar.tintColor = .button.lavender
    }
}

// MARK: - SetUp
private extension RxTableViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension RxTableViewController {
    @objc func goRxButtonPage() {
        let rxButtonVC = RxButtonViewController()
        rxButtonVC.hidesBottomBarWhenPushed = true // VC tabbar 숨기기
        navigationController?.pushViewController(rxButtonVC, animated: true)
    }
}

// MARK: - Delegate
extension RxTableViewController {
    
}
