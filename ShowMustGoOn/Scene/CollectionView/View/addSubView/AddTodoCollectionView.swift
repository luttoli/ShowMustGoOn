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
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(AddListTableViewCell.self, forCellReuseIdentifier: AddListTableViewCell.identifier)
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
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
        addSubview(tableView)
        
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Constants.spacing.px10)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Method
extension AddTodoCollectionView {
    
}

// MARK: - UITableViewDelegate
extension AddTodoCollectionView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray6
        
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.size.size40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddListTableViewCell.identifier, for: indexPath) as? AddListTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size130
    }
    
    // 셀 삭제 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}
