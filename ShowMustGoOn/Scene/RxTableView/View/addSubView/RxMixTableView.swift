//
//  RxMixTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

protocol RxMixTableViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath, item: Any)
}

class RxMixTableView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxMixViewModel()
    weak var delegate: RxMixTableViewDelegate?
    
    // MARK: - Components
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RxHorizontalTableViewCell.self, forCellReuseIdentifier: RxHorizontalTableViewCell.identifier)
        tableView.register(VerticalTableViewCell.self, forCellReuseIdentifier: VerticalTableViewCell.identifier)
        //세로 리스트 셀 구현할거고
        tableView.backgroundColor = .clear
        return tableView
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
private extension RxMixTableView {
    func setUp() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension RxMixTableView {
    private func bindTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<MixSection>(
            configureCell: { dataSource, tableView, indexPath, item in
                if indexPath.section == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: RxHorizontalTableViewCell.identifier, for: indexPath) as? RxHorizontalTableViewCell,
                          let images = item as? [UIImage?] else {
                        return UITableViewCell()
                    }
                    
                    cell.configure(with: images)
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: VerticalTableViewCell.identifier, for: indexPath) as? VerticalTableViewCell,
                          let subNews = item as? SubNews else {
                        return UITableViewCell()
                    }
                    
                    cell.selectionStyle = .none
                    cell.configure(with: subNews)
                    return cell
                }
            }
        )

        // 테이블뷰 데이터 바인딩
        viewModel.mixSections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // 테이블뷰 선택 이벤트 처리
        tableView.rx.itemSelected
            .withLatestFrom(viewModel.mixSections) { (indexPath, sections) -> (IndexPath, Any)? in
                guard indexPath.section < sections.count,
                      indexPath.row < sections[indexPath.section].items.count else {
                    return nil
                }
                return (indexPath, sections[indexPath.section].items[indexPath.row])
            }
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] indexPath, item in
                guard let self = self else { return }
                self.delegate?.didSelectItem(at: indexPath, item: item)
                print("Selected: \(item)")
            })
            .disposed(by: disposeBag)

        // 테이블뷰 높이 설정
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: - Method
extension RxMixTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Constants.size.size260 // 0번 섹션 높이
        } else {
            return Constants.size.size100 // 나머지 섹션 높이
        }
    }
}
