//
//  RxSectionTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources
import SnapKit

class RxSectionTableView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxSectionViewModel()
    // RxDataSources 라이브러리를 사용하여 섹션 기반의 데이터를 테이블 뷰와 바인딩할 때 필요한 타입을 정의
    typealias MultiplyDataSource = RxTableViewSectionedReloadDataSource<MultiplySection>
    
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

        // MARK: - 구구단 다른 코드로 구현, 비교할 예정 - 출력 확인
//        viewModel.m.subscribe(onNext: { sections in
//            for section in sections {
//                for item in section {
//                    print("\(item.frontNumber) x \(item.backNumber) = \(item.resultNumber)")
//                }
//            }
//        }).disposed(by: disposeBag)
    }
}

// MARK: - Method
extension RxSectionTableView {
    func createDataSource() -> MultiplyDataSource {
        return MultiplyDataSource { _, tableView, indexPath, item in
            // 셀 설정
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier) as? SectionTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: item) // 셀에 데이터를 넣음
            return cell
        } titleForHeaderInSection: { dataSource, index in
            // 섹션 헤더를 설정
            dataSource[index].header
        }
    }
    
    func bindTableView() {
        let dataSource = createDataSource()
        
        // 데이터 바인딩
        viewModel.multiplySections
            .bind(to: multiplicationTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // 셀 클릭 이벤트 처리
        multiplicationTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.toggleResult(at: indexPath) // 클릭한 셀의 상태 업데이트
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 기본 노출
//    func bindTableView() {
//        // 데이터 바인딩
//        viewModel.multiplyData
//            .bind(to: multiplicationTableView.rx.items(cellIdentifier: SectionTableViewCell.identifier)) { index, data, cell in
//                guard let cell = cell as? SectionTableViewCell else { return }
//                cell.configure(with: data) // 상태에 따라 셀 업데이트
//            }
//            .disposed(by: disposeBag)
//        
//        // 셀 클릭 이벤트 처리
//        multiplicationTableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                self?.viewModel.toggleResult(at: indexPath.row) // 클릭한 셀의 상태 업데이트
//            })
//            .disposed(by: disposeBag)
//    }
}

