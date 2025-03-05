//
//  AddBackMiracleViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/4/25.
//

import UIKit

import SnapKit

class AddBackMiracleViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components    
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "챌린지 타이틀을 입력하세요."
        textField.borderStyle = .roundedRect
        textField.font = .toPretendard(size: Constants.size.size15, weight: .Regular)
        textField.backgroundColor = .systemBackground
        textField.textColor = .text.black
        textField.clearButtonMode = .whileEditing
        return textField
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
extension AddBackMiracleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension AddBackMiracleViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "빽일의 기적 추가", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension AddBackMiracleViewController {
    func setUp() {
        view.addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
    }
}

// MARK: - Method
private extension AddBackMiracleViewController {
    
}

// MARK: - Delegate
extension AddBackMiracleViewController {
    
}
