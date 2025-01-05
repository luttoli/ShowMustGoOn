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
        multiplicationTableView.register(SectionTableViewCell.self, forCellReuseIdentifier: SectionTableViewCell.identifier)
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
        
        
        
        viewModel.m.subscribe(onNext: { sections in
            for section in sections {
                for item in section {
                    print("\(item.frontNumber) x \(item.backNumber) = \(item.resultNumber)")
                }
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Method
extension RxSectionTableView {
//    func bindTableView() {
//        viewModel.multiplyData
//            .bind(to: multiplicationTableView.rx.items(cellIdentifier: SectionTableViewCell.identifier)) { index, data, cell in
//                guard let cell = cell as? SectionTableViewCell else { return }
//                cell.configure(with: data)
//            }
//            .disposed(by: disposeBag)
//        
//        multiplicationTableView.rx.modelSelected(SectionModel.self)
//            .subscribe(onNext: { model in
//                print("\(model.frontNumber * model.backNumber)")
//            })
//            .disposed(by: disposeBag)
//    }
    
    func bindTableView() {
        // 데이터 바인딩
        viewModel.multiplyData
            .bind(to: multiplicationTableView.rx.items(cellIdentifier: SectionTableViewCell.identifier)) { index, data, cell in
                guard let cell = cell as? SectionTableViewCell else { return }
                cell.configure(with: data) // 상태에 따라 셀 업데이트
            }
            .disposed(by: disposeBag)
        
        // 셀 클릭 이벤트 처리
        multiplicationTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.toggleResult(at: indexPath.row) // 클릭한 셀의 상태 업데이트
            })
            .disposed(by: disposeBag)
    }
}
