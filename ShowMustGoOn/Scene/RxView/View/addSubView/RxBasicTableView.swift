//
//  RxBasicTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxBasicTableView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let numbers = Observable.of(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"])
    let titles = Observable.of(["가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"])
    
    // MARK: - Components
    var rxBasicTableView: UITableView = {
        let rxBasicTableView = UITableView(frame: .zero, style: .plain)
        rxBasicTableView.register(RxBasicTableViewCell.self, forCellReuseIdentifier: RxBasicTableViewCell.identifier)
        rxBasicTableView.backgroundColor = .clear
        rxBasicTableView.bounces = true
        rxBasicTableView.alwaysBounceVertical = true
        rxBasicTableView.isScrollEnabled = true
        rxBasicTableView.showsVerticalScrollIndicator = true
        rxBasicTableView.allowsSelection = true
        rxBasicTableView.allowsMultipleSelection = true
        rxBasicTableView.contentInset = .zero
        rxBasicTableView.separatorStyle = .singleLine
        rxBasicTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        rxBasicTableView.rowHeight = Constants.size.size50 // 고정 높이 설정
        return rxBasicTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        bindTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension RxBasicTableView {
    func setUp() {
        addSubview(rxBasicTableView)
        
        rxBasicTableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension RxBasicTableView {
    func bindTableView() {
        Observable
            .combineLatest(numbers, titles) // numbers와 titles Observable을 결합
            .map { zip($0, $1) } // 두 배열의 각 요소를 짝지어 (numbers, titles) 형태의 튜플 배열로 변환
            .bind(to: rxBasicTableView.rx.items(cellIdentifier: RxBasicTableViewCell.identifier)) { index, model, cell in
                guard let customCell = cell as? RxBasicTableViewCell else { return }
                customCell.numLabel.text = "\(model.0)." // 튜플의 첫 번째 값
                customCell.titleLabel.text = model.1 // 튜플의 두 번째 값
            }
            .disposed(by: disposeBag)
        
        rxBasicTableView.rx.modelSelected((String, String).self) // 테이블 뷰에서 특정 셀을 선택했을 때 동작
            .subscribe(onNext: { model in
                print("\(model.0). \(model.1)")
            })
            .disposed(by: disposeBag)
    }
}
