//
//  FirstView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/31/24.
//

import UIKit

import SnapKit

class FirstView: UIView {
    // MARK: - Properties
    var tableViewCellItem = Array(1...30).map {"\($0)"}
    
    // MARK: - Components
    var basicTableView: UITableView = {
        let basicTableView = UITableView(frame: .zero, style: .plain)
        basicTableView.register(NumTableViewCell.self, forCellReuseIdentifier: NumTableViewCell.identifier)
        basicTableView.backgroundColor = .clear
        // 스크롤 설정
        basicTableView.bounces = true // 스크롤중 테이블뷰 하단에 도달했을 때 반동 효과 여부
        basicTableView.alwaysBounceVertical = true // cell 컨텐츠가 뷰 높이보다 작아도 수직 방향 반동 효과 여부
        basicTableView.isScrollEnabled = true // 스크롤 가능 여부
        basicTableView.showsVerticalScrollIndicator = true // 스크롤 시 스크롤바 노출 여부
        // 선택
        basicTableView.allowsSelection = true // 하나 선택
        basicTableView.allowsMultipleSelection = true // 중복 선택
        // 여백
        basicTableView.contentInset = .zero // 테이블뷰 컨텐츠 여백
        // 표시
        basicTableView.separatorStyle = .singleLine // 구분선 노출 여부
        basicTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 구분선 여백 설정
        basicTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: basicTableView.frame.width, height: 50)) // 헤더뷰
        basicTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: basicTableView.frame.width, height: 50)) // 푸터뷰
        // 성능
        basicTableView.estimatedRowHeight = 44
        basicTableView.rowHeight = UITableView.automaticDimension
        return basicTableView
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
private extension FirstView {
    func setUp() {
        addSubview(basicTableView)
        
        basicTableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        basicTableView.delegate = self
        basicTableView.dataSource = self
    }
}

// MARK: - Method
extension FirstView {

}

// MARK: - delegate
extension FirstView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCellItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NumTableViewCell.identifier, for: indexPath) as? NumTableViewCell else { return UITableViewCell() }
        
        cell.numLabel.text = tableViewCellItem[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
