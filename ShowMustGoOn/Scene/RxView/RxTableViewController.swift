//
//  RxViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/3/24.
//

import UIKit

import RxSwift
import SnapKit

class RxTableViewController: UIViewController {
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
extension RxTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        
        
        let publishSubject = PublishSubject<String>()

        // 첫 번째 구독자
        publishSubject.subscribe(onNext: { value in
            print("첫 번째 구독자: \(value)")
        })

        // 첫 번째 구독자가 구독된 후 이벤트 발생
        publishSubject.onNext("RxSwift")

        // 두 번째 구독자 추가
        publishSubject.subscribe(onNext: { value in
            print("두 번째 구독자: \(value)")
        })

        // 이후 이벤트 발생
        publishSubject.onNext("새로운 이벤트")
        

        
        let behaviorSubject = BehaviorSubject(value: "초기값")

        // 첫 번째 구독자
        behaviorSubject.subscribe(onNext: { value in
            print("첫 번째 구독자: \(value)")
        })

        // 첫 번째 구독자에게 새로운 값 방출
        behaviorSubject.onNext("첫 번째 값")

        // 두 번째 구독자 추가
        behaviorSubject.subscribe(onNext: { value in
            print("두 번째 구독자: \(value)")
        })

        // 이후 새로운 값 방출
        behaviorSubject.onNext("두 번째 값")
        
        
    }
}

// MARK: - Navigation
extension RxTableViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "RxSwift Practice", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension RxTableViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension RxTableViewController {
    //    func <#name#>() {
    //
    //    }
}

// MARK: - Delegate
extension RxTableViewController {
    
}
