//
//  MixTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

protocol MixTableViewDelegate: AnyObject {
    func didSelectItem(with url: String)
}

class MixTableView: UIView {
    // MARK: - Properties
    var viewModel = MixViewModel()
    weak var delegate: MixTableViewDelegate?
    
    // MARK: - Components
    var eSportsTableView: UITableView = {
        let eSportsTableView = UITableView(frame: .zero, style: .plain)
        eSportsTableView.register(HorizontalTableViewCell.self, forCellReuseIdentifier: HorizontalTableViewCell.identifier)
        eSportsTableView.register(VerticalTabelViewCell.self, forCellReuseIdentifier: VerticalTabelViewCell.identifier)
        eSportsTableView.backgroundColor = .clear
        return eSportsTableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension MixTableView {
    func setUp() {
        addSubview(eSportsTableView)
        
        eSportsTableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        eSportsTableView.delegate = self
        eSportsTableView.dataSource = self
    }
}

// MARK: - Method
extension MixTableView {

}

// MARK: - delegate
extension MixTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.eSportNews.first?.subNews.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalTableViewCell.identifier, for: indexPath) as? HorizontalTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VerticalTabelViewCell.identifier, for: indexPath) as? VerticalTabelViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.configure(with: viewModel.eSportNews[0].subNews[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Constants.size.size260
        } else {
            return Constants.size.size100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubNews = viewModel.eSportNews[0].subNews[indexPath.row]
        let url = selectedSubNews.url ?? ""

        delegate?.didSelectItem(with: url)
    }
}
