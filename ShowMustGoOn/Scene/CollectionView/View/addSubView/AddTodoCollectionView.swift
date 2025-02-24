//
//  AddTodoCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

import SnapKit

class AddTodoCollectionView: UIView {
    // MARK: - Properties
    
    
    // MARK: - Components
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력하세요."
        textField.borderStyle = .roundedRect
        textField.font = .toPretendard(size: Constants.size.size15, weight: .Regular)
        textField.backgroundColor = .systemBackground
        textField.textColor = .text.black
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    var addTodoButton = CustomButton(type: .iconButton(icon: .plus))
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension AddTodoCollectionView {
    func setUp() {
        addSubview(textField)
        addSubview(addTodoButton)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
        }
//        textField.delegate = self
        
        addTodoButton.snp.makeConstraints {
            $0.centerY.equalTo(textField)
            $0.leading.equalTo(textField.snp.trailing).offset(Constants.spacing.px10)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension AddTodoCollectionView {
    
}

// MARK: - delegate
extension AddTodoCollectionView {
    
}
