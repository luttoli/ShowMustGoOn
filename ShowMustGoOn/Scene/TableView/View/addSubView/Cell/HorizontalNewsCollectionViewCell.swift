//
//  HorizontalNewsCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

class HorizontalNewsCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    var newsImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension HorizontalNewsCollectionViewCell {
    func setUp() {
        contentView.addSubview(newsImageView)
        
        newsImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.size.size220)
        }
        newsImageView.layer.cornerRadius = Constants.radius.px10
        newsImageView.layer.masksToBounds = true
        newsImageView.contentMode = .scaleToFill
    }
}

// MARK: - Method
extension HorizontalNewsCollectionViewCell {
    func configure(with mainNews: ESportsModel, at index: Int) {
        newsImageView.image = mainNews.mainImage[index]
    }
}
