//
//  BasicCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/24/25.
//

import UIKit

class BasicCollectionView: UIView {
    // MARK: - Properties
    
    
    // MARK: - Components
    var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier)
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier)
        collectionView.backgroundColor = .yellow
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
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
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCollectionViewCell.identifier, for: indexPath) as? KeyboardCollectionViewCell else { return UICollectionViewCell() }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 1, height: 1)
    }
    
    // 좌우
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
