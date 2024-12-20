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
        // 스크롤 설정
        eSportsTableView.bounces = true // 스크롤중 테이블뷰 하단에 도달했을 때 반동 효과 여부
        eSportsTableView.alwaysBounceVertical = true // cell 컨텐츠가 뷰 높이보다 작아도 수직 방향 반동 효과 여부
        eSportsTableView.isScrollEnabled = true // 스크롤 가능 여부
        eSportsTableView.showsVerticalScrollIndicator = true // 스크롤 시 스크롤바 노출 여부
        // 여백
        eSportsTableView.contentInset = .zero // 테이블뷰 컨텐츠 여백
        // 표시
        eSportsTableView.separatorStyle = .none // 구분선 노출 여부
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
