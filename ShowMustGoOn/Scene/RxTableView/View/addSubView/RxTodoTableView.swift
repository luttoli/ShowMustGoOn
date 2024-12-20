//
//  RxTodoTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/14/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxTodoTableView: UIView {
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
        configureDismissKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension RxTodoTableView {
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
    }
}

// MARK: - Method
extension RxTodoTableView {
    private func bindViewModel() {
        // Input: Add 버튼 클릭 시, TextField 내용 전달
        addButton.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty) // 텍스트 필드 값 가져오기
            .filter { !$0.isEmpty } // 빈 값 무시
            .distinctUntilChanged() // 값이 변하지 않으면 무시
            .withUnretained(self)
            .do(onNext: { owner, text in
                owner.viewModel.addTodo.onNext(text) // ViewModel에 값 전달
            })
            .subscribe(onNext: { owner, _ in
                owner.textField.text = "" // 값 전달 후 초기화
            })
            .disposed(by: disposeBag)
        
        // Output: Todo 리스트를 TableView와 바인딩
        viewModel.rxTodoCellData
            .bind(to: tableView.rx.items(cellIdentifier: "TodoCell")) { index, rxTodoCellData, cell in
                cell.textLabel?.text = rxTodoCellData.title
                cell.textLabel?.textColor = rxTodoCellData.textColor
            }
            .disposed(by: disposeBag)
        
        // 선택 이벤트
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.toggleComplete)
            .disposed(by: disposeBag)
    }
    
    // 화면 클릭 시 키보드 내리기
    func configureDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension RxTodoTableView: UITextFieldDelegate {
    // 텍스트필드 리턴키 눌리면 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
