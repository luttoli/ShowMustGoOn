//
//  MainNewsTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

class MainNewsTableViewCell: UITableViewCell {
    // MARK: - Properties
    var viewModel = ThirdViewModel()
    
    // MARK: - Components
    let horizontalNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let horizontalNewsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalNewsCollectionView.register(HorizontalNewsCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalNewsCollectionViewCell.identifier)
        horizontalNewsCollectionView.backgroundColor = .clear
        horizontalNewsCollectionView.showsHorizontalScrollIndicator = false
        horizontalNewsCollectionView.isPagingEnabled = true
        return horizontalNewsCollectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension MainNewsTableViewCell {
    func setUp() {
        contentView.addSubview(horizontalNewsCollectionView)
        
        horizontalNewsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        horizontalNewsCollectionView.delegate = self
        horizontalNewsCollectionView.dataSource = self
    }
}

// MARK: - Method
extension MainNewsTableViewCell {
    func configure() {
        
    }
}

// MARK: - CollectionViewDelegate
extension MainNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.eSportNews.first?.mainImage.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalNewsCollectionViewCell.identifier, for: indexPath) as? HorizontalNewsCollectionViewCell else { return UICollectionViewCell() }
        
        let model = viewModel.eSportNews[0]
        cell.configure(with: model, at: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
