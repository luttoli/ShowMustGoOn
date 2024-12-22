//
//  TodoTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/19/24.
//

import UIKit

import SnapKit

class TodoTableView: UIView {
    // MARK: - Properties
    var viewModel = TodoViewModel()
    
    // MARK: - Components
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "여기에 입력하세요."
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14)
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    let addButton = CustomButton(type: .textButton(title: "추가", color: .lavender, size: .small))
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        updataTodo()
        didTabAddButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension TodoTableView {
    func setUp() {
        addSubview(textField)
        addSubview(addButton)
        addSubview(tableView)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(addButton.snp.leading).offset(-10)
            make.height.equalTo(40)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(textField)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Method
extension TodoTableView {
    // 데이터 업데이트
    func updataTodo() {
        viewModel.onTodoUpdated = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    // 추가 버튼 클릭
    func didTabAddButton() {
        self.addButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            
            guard let inputText = self.textField.text else { return }
            self.viewModel.addTodo(title: inputText, isCompleted: false)
            self.textField.text = "" // 추가 버튼 눌리고 나서 비우기
        }), for: .touchUpInside)
    }
}

// MARK: - delegate
extension TodoTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }

        cell.configure(with: viewModel.todoData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.todoData[indexPath.row].isCompleted.toggle()
        viewModel.onTodoUpdated?()
        print(viewModel.todoData[indexPath.row])
    }
}
