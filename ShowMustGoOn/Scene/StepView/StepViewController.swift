//
//  StepViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/18/24.
//

import UIKit

import Combine
import SnapKit

class StepViewController: UIViewController {
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
extension StepViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension StepViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "Step Practice", size: Constants.size.size30, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension StepViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension StepViewController {
    //    func <#name#>() {
    //
    //    }
}

// MARK: - Delegate
extension StepViewController {
    
}

