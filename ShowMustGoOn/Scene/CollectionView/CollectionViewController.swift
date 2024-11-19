//
//  CollectionViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/31/24.
//

import UIKit

import SnapKit

class CollectionViewController: UIViewController {
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
extension CollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension CollectionViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "CollectionView Practice", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension CollectionViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension CollectionViewController {
    //    func <#name#>() {
    //
    //    }
}

// MARK: - Delegate
extension CollectionViewController {
    
}
