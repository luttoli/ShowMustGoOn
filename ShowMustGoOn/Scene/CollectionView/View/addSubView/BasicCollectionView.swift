//
//  BasicCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/24/25.
//

import UIKit

import SnapKit

class BasicCollectionView: UIView {
    // MARK: - Properties
    let viewModel = BasicCollectionViewModel()
    
    // MARK: - Components
    var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPrefetchingEnabled = true
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = UIRefreshControl()
        return collectionView
    }()
    
    var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPrefetchingEnabled = true
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        verticalCollectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didPullToRefresh() {
        // 데이터 갱신 처리
        verticalCollectionView.refreshControl?.endRefreshing()
    }
}

// MARK: - SetUp
private extension BasicCollectionView {
    func setUp() {
        addSubview(verticalCollectionView)
        addSubview(horizontalCollectionView)
        
        verticalCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self
        
        horizontalCollectionView.snp.makeConstraints {
            $0.top.equalTo(verticalCollectionView.snp.bottom)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        horizontalCollectionView.delegate = self
        horizontalCollectionView.dataSource = self
    }
}

// MARK: - Method
extension BasicCollectionView {

}

// MARK: - delegate
extension BasicCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.number.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as? BasicCollectionViewCell else { return UICollectionViewCell() }
        cell.colorView.backgroundColor = .background.lavender
        cell.configure(with: viewModel.number[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 1 * 2
        
        if collectionView == verticalCollectionView {
            let width = (collectionView.frame.width - spacing) / 3
            return CGSize(width: width, height: width)
        } else {
            let width = (collectionView.frame.height - spacing) / 3
            return CGSize(width: width, height: width)
        }
    }
    
    // 좌우
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 상하
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
