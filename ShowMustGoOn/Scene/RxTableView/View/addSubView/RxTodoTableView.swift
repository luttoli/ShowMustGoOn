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
    let viewModel = RxTodoTableViewModel()
    
    // MARK: - Components
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "여기에 입력하세요."
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: Constants.size.size15)
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.clearButtonMode = .whileEditing
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
private extension RxTodoTableView {
    func setUp() {
        addSubview(textField)
        addSubview(addButton)
        addSubview(tableView)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Constants.size.size20)
            $0.leading.equalToSuperview().offset(Constants.size.size20)
            $0.trailing.equalTo(addButton.snp.leading).offset(-Constants.size.size10)
            $0.height.equalTo(Constants.size.size40)
        }
        
        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.size.size20)
            $0.centerY.equalTo(textField)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Constants.size.size20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Method
extension RxTodoTableView {
    private func bindViewModel() {
        // MARK: - 데이터 구조를 두개로 가져갈 때
        // Input: Add 버튼 클릭 시, TextField 내용 전달
//        addButton.rx.tap
//            .withLatestFrom(textField.rx.text.orEmpty) // 텍스트 필드 값 가져오기
//            .filter { !$0.isEmpty } // 빈 값 무시
//            .distinctUntilChanged() // 값이 변하지 않으면 무시
//            .withUnretained(self)
//            .do(onNext: { owner, text in
//                owner.viewModel.addTodo.onNext(text) // ViewModel에 값 전달
//            })
//            .subscribe(onNext: { owner, _ in
//                owner.textField.text = "" // 값 전달 후 초기화
//            })
//            .disposed(by: disposeBag)
//        
//        // Output: Todo 리스트를 TableView와 바인딩
//        viewModel.rxTodoCellData
//            .bind(to: tableView.rx.items(cellIdentifier: "TodoCell")) { index, rxTodoCellData, cell in
//                cell.textLabel?.text = rxTodoCellData.title
//                cell.textLabel?.textColor = rxTodoCellData.textColor
//            }
//            .disposed(by: disposeBag)
//        
//        // 선택 이벤트
//        tableView.rx.itemSelected
//            .map { $0.row }
//            .bind(to: viewModel.toggleComplete)
//            .disposed(by: disposeBag)
        
        // MARK: - 데이터 구조를 하나로 가져갈 때
        // Input: Add 버튼 클릭 시 TextField 내용 전달
        addButton.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty)
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .withUnretained(self)
            .do(onNext: { owner, text in
                owner.viewModel.addTodoItem(title: text)
            })
            .subscribe(onNext: { owner, _ in
                owner.textField.text = ""
            })
            .disposed(by: disposeBag)
        
        // Output: Todo 리스트를 TableView에 바인딩
        viewModel.rxTodoCellData
            .bind(to: tableView.rx.items(cellIdentifier: "TodoCell")) { index, rxTodoCellData, cell in
                cell.textLabel?.text = rxTodoCellData.title
                cell.textLabel?.textColor = rxTodoCellData.textColor
            }
            .disposed(by: disposeBag)
        
        // 선택 이벤트
        tableView.rx.itemSelected
            .map { $0.row }
            .subscribe(onNext: { [weak self] index in
                self?.viewModel.toggleTodoItem(at: index)
            })
            .disposed(by: disposeBag)
        
        // 선택한 셀의 선택 상태 해제
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
