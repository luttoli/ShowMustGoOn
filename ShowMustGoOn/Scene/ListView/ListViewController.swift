//
//  ListViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

import Combine
import SnapKit

class ListViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    var listSegment: UISegmentedControl = {
        let listSegment = UISegmentedControl(items: ["테이블뷰", "콜랙션뷰"])
        listSegment.selectedSegmentIndex = 0
        return listSegment
    }()
    
    let firstView: UIView = {
        let firstView = UIView()
        firstView.backgroundColor = .red
        return firstView
    }()
    
    let secondView: UIView = {
        let secondView = UIView()
        secondView.backgroundColor = .blue
        return secondView
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
extension ListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension ListViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "List Practice", size: Constants.size.size30, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension ListViewController {
    func setUp() {
        view.addSubview(listSegment)
        
        listSegment.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constants.size.size50)
        }

        view.addSubview(firstView)
        firstView.snp.makeConstraints {
            $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        listSegment.addAction(UIAction(handler: { [weak self] _ in
            self?.changeView()
        }), for: .valueChanged)
    }
}

// MARK: - Method
private extension ListViewController {
    func changeView() {
        if listSegment.selectedSegmentIndex == 0 {
            // 첫 번째 뷰를 보여줌
            secondView.removeFromSuperview() // 다른 뷰는 제거
            view.addSubview(firstView)
            firstView.snp.makeConstraints {
                $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
            }
        } else {
            // 두 번째 뷰를 보여줌
            firstView.removeFromSuperview() // 다른 뷰는 제거
            view.addSubview(secondView)
            secondView.snp.makeConstraints {
                $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
            }
        }
    }
}

// MARK: - Delegate
extension ListViewController {
    
}
