//
//  RxExViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/11/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxExViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
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
extension RxExViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUp()
    }
}

// MARK: - SetUp
private extension RxExViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension RxExViewController {
    //    func <#name#>() {
    //
    //    }
}

// MARK: - Delegate
extension RxExViewController {
    
}

