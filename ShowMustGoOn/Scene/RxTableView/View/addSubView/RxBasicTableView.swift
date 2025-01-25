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
    let viewModel = RxBasicTableViewModel()
    
    // MARK: - Components
    var rxBasicTableView: UITableView = {
        let rxBasicTableView = UITableView(frame: .zero, style: .plain)
        rxBasicTableView.register(BasicTableViewCell.self, forCellReuseIdentifier: BasicTableViewCell.identifier)
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
        viewModel.data
            .bind(to: rxBasicTableView.rx.items(cellIdentifier: BasicTableViewCell.identifier)) { index, model, cell in
                guard let cell = cell as? BasicTableViewCell else { return }
                cell.numLabel.text = "\(model.number)."
                cell.titleLabel.text = model.title
            }
            .disposed(by: disposeBag)
        
        rxBasicTableView.rx.modelSelected(BasicTableModel.self)
            .subscribe(onNext: { model in
                print("\(model.number). \(model.title)")
            })
            .disposed(by: disposeBag)
    }
}
