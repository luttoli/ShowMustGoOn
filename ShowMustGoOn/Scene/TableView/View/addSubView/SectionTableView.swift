//
//  SectionTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/1/24.
//

import UIKit

import SnapKit

class SectionTableView: UIView {
    // MARK: - Properties
    private let viewModel = SecondViewModel()
    
    var selectedIndexPaths: Set<IndexPath> = []
    
    // MARK: - Components
    var multiplicationTableView: UITableView = {
        let multiplicationTableView = UITableView(frame: .zero, style: .grouped)
        multiplicationTableView.register(MultiplyTableViewCell.self, forCellReuseIdentifier: MultiplyTableViewCell.identifier)
        multiplicationTableView.backgroundColor = .clear
        // 스크롤 설정
        multiplicationTableView.bounces = true // 스크롤중 테이블뷰 하단에 도달했을 때 반동 효과 여부
        multiplicationTableView.alwaysBounceVertical = true // cell 컨텐츠가 뷰 높이보다 작아도 수직 방향 반동 효과 여부
        multiplicationTableView.isScrollEnabled = true // 스크롤 가능 여부
        multiplicationTableView.showsVerticalScrollIndicator = true // 스크롤 시 스크롤바 노출 여부
        // 선택
        multiplicationTableView.allowsSelection = true // 하나 선택
        // 여백
        multiplicationTableView.contentInset = .zero // 테이블뷰 컨텐츠 여백
        multiplicationTableView.tableFooterView = UIView(frame: .zero)
        multiplicationTableView.sectionFooterHeight = 0
        // 표시
        multiplicationTableView.separatorStyle = .singleLine // 구분선 노출 여부
        multiplicationTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 구분선 여백 설정
        return multiplicationTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
}

// MARK: - SetUp
private extension SectionTableView {
    func setUp() {
        addSubview(multiplicationTableView)
        
        multiplicationTableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        multiplicationTableView.delegate = self
        multiplicationTableView.dataSource = self
    }
}

// MARK: - Method
extension SectionTableView {

}

// MARK: - delegate
extension SectionTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.frontNumbers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .background.lavender
        
        let headerLabel = CustomLabel(title: "\(viewModel.frontNumbers[section])단", size: Constants.size.size15, weight: .Regular, color: .text.white)
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(headerView)
            $0.leading.equalTo(headerView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(headerView).offset(-Constants.margin.horizontal)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.size.size50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.backNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MultiplyTableViewCell", for: indexPath) as? MultiplyTableViewCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.multiplyData[indexPath.section][indexPath.row]
        let isCellSelected = selectedIndexPaths.contains(indexPath)
        cell.configure(with: model, showResult: isCellSelected)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath) {
            selectedIndexPaths.remove(indexPath)
        } else {
            selectedIndexPaths.insert(indexPath)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
}
