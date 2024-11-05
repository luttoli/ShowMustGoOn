//
//  VerticalNewsTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

class VerticalNewsTableViewCell: UITableViewCell {
    // MARK: - Components
    var newsImageView = UIImageView()
    var newsTitleLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)

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
private extension VerticalNewsTableViewCell {
    func setUp() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        
        newsImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.width.equalTo(Constants.size.size100)
            $0.height.equalTo(Constants.size.size50)
        }
        newsImageView.layer.cornerRadius = Constants.radius.px8
        newsImageView.layer.masksToBounds = true
        
        newsTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(newsImageView).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
        }
        newsTitleLabel.numberOfLines = 0
    }
}

// MARK: - Method
extension VerticalNewsTableViewCell {
    func configure() {
        
    }
}
