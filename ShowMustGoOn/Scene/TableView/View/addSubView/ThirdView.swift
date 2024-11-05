//
//  ThirdView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

class ThirdView: UIView {
    // MARK: - Properties
    var images = []
    
    // MARK: - Components
    var eSportsTableView: UITableView = {
        let eSportsTableView = UITableView(frame: .zero, style: .plain)
        eSportsTableView.register(MainNewsTableViewCell.self, forCellReuseIdentifier: MainNewsTableViewCell.identifier)
        eSportsTableView.register(VerticalNewsTableViewCell.self, forCellReuseIdentifier: VerticalNewsTableViewCell.identifier)
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
        super.init(coder: coder)
        setUp()
    }
}

// MARK: - SetUp
private extension ThirdView {
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
extension ThirdView {

}

// MARK: - delegate
extension ThirdView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainNewsTableViewCell.identifier, for: indexPath) as? MainNewsTableViewCell else { return UITableViewCell() }
            
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VerticalNewsTableViewCell.identifier, for: indexPath) as? VerticalNewsTableViewCell else { return UITableViewCell() }
            
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        } else {
            return 100
        }
    }
}
