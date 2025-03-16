//
//  RxCollectionViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/16/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxCollectionViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension RxCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension RxCollectionViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "RxSwift CollectionView", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension RxCollectionViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension RxCollectionViewController {
    
}
