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
    private let viewModel = SectionViewModel()
    
    // MARK: - Components
    var multiplicationTableView: UITableView = {
        let multiplicationTableView = UITableView(frame: .zero, style: .grouped)
        multiplicationTableView.register(SectionTableViewCell.self, forCellReuseIdentifier: SectionTableViewCell.identifier)
        multiplicationTableView.backgroundColor = .clear
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
    
    // 기본 텍스트 헤더
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(viewModel.frontNumbers[section])단"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.backNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier, for: indexPath) as? SectionTableViewCell else { return UITableViewCell() }
        
        let model = viewModel.multiplyData[indexPath.section][indexPath.row]
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleResult(at: indexPath) // 상태 업데이트
        tableView.reloadRows(at: [indexPath], with: .automatic) // 해당 셀만 업데이트
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.size.size50
    }
}
