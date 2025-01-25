//
//  HorizontalCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let newsImageView: UIImageView = {
        let newsImageView = UIImageView()
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        return newsImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension HorizontalCollectionViewCell {
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
extension HorizontalCollectionViewCell {
    func configure(with mainNews: MixTableModel, at index: Int) {
        newsImageView.image = mainNews.mainImage[index]
    }
}
