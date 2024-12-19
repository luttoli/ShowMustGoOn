//
//  RxSectionTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxSectionTableView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxSectionViewModel()
    
    // MARK: - Components
    let multiplicationTableView: UITableView = {
        let multiplicationTableView = UITableView()
        multiplicationTableView.register(MultiplyTableViewCell.self, forCellReuseIdentifier: MultiplyTableViewCell.identifier)
        return multiplicationTableView
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
private extension RxSectionTableView {
    func setUp() {
        addSubview(multiplicationTableView)
        
        multiplicationTableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension RxSectionTableView {
    func bindTableView() {
        viewModel.multiplyData
            .bind(to: multiplicationTableView.rx.items(cellIdentifier: MultiplyTableViewCell.identifier)) { index, data, cell in
                guard let cell = cell as? MultiplyTableViewCell else { return }
                cell.frontNumberLabel.text = "\(data.frontNumber)"
                cell.backNumberLabel.text = "\(data.backNumber)"
                cell.resultNumberLabel.text = data.resultNumber
            }
            .disposed(by: disposeBag)
        
        multiplicationTableView.rx.modelSelected(SectionModel.self)
            .subscribe(onNext: { model in
                print("\(model.frontNumber * model.backNumber)")
            })
            .disposed(by: disposeBag)
    }
}
