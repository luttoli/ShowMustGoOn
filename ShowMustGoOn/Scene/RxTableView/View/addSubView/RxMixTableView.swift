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

class RxMixTableView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxMixViewModel()
    
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
        tableView.delegate = self
    }
}

// MARK: - Method
extension RxMixTableView {
//    func bindTableView() {
//        viewModel.tableViewData
////            .bind(to: tableView.rx.items(cellIdentifier: "RxHorizontalTableViewCell", cellType: RxHorizontalTableViewCell.self)) { index, sectionData, cell in
////                
////            }
//            .bind(to: tableView.rx.items(cellIdentifier: "VerticalTabelViewCell", cellType: VerticalTabelViewCell.self)) { index, sectionData, cell in
////                cell.newsImageView.image = sectionData.subNews[index].subImage
////                cell.newsTitleLabel.text = sectionData.subNews[index].subTitle
//                cell.configure(with: sectionData.subNews[index])
//            }
//            .disposed(by: disposeBag)
//    }
    
    func bindTableView() {
        let dataSource = RxTableViewSectionedReloadDataSource<MixSection>(
            configureCell: { dataSource, tableView, indexPath, item in
                print("IndexPath: \(indexPath), Item: \(item)") // 로그로 데이터 확인
                
                if indexPath.section == 0 {
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: RxHorizontalTableViewCell.identifier, for: indexPath) as? RxHorizontalTableViewCell else {
                        return UITableViewCell()
                    }
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: VerticalTableViewCell.identifier, for: indexPath) as? VerticalTableViewCell else {
                        return UITableViewCell()
                    }

                    cell.configure(with: item.subNews[indexPath.row])
                    return cell
                }
            }
        )
        
        viewModel.tableViewData
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - delegate
extension RxMixTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Constants.size.size260
        } else {
            return Constants.size.size100
        }
    }
}
