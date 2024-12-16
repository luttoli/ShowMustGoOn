//
//  RxTodoListView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxTodoListView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxTodoListViewModel()
    
    // MARK: - Components
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "여기에 입력하세요."
        return textField
    }()
    
    private let addButton = CustomButton(type: .textButton(title: "추가", color: .lavender, size: .small))
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension RxTodoListView {
    func setUp() {
        addSubview(tableView)
        addSubview(addButton)
        addSubview(textField)
        
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
    }
}

// MARK: - Method
extension RxTodoListView {
    private func bindViewModel() {
        // Input: Add 버튼 클릭 시, TextField 내용 전달
        addButton.rx.tap
            .withUnretained(self)
            .do(onNext: { owner, _ in // do 연산자는 스트림의 값을 변경하지 않고 작업
                owner.textField.text = ""
            })
            .withLatestFrom(textField.rx.text.orEmpty) // 현재 스트림 발생 이벤트를 사용해 최신값을 가져옴 = 초기화 전에 값을 가져옴
            .bind(to: viewModel.addTodo)
            .disposed(by: disposeBag)
        
        // Output: Todo 리스트를 TableView와 바인딩
        viewModel.todoItems
            .bind(to: tableView.rx.items(cellIdentifier: "TodoCell")) { index, todo, cell in
                cell.textLabel?.text = todo.title
                cell.textLabel?.textColor = todo.isCompleted ? .text.lavender : .text.black
            }
            .disposed(by: disposeBag)
        
        // 선택 이벤트
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.toggleComplete)
            .disposed(by: disposeBag)
    }
}
