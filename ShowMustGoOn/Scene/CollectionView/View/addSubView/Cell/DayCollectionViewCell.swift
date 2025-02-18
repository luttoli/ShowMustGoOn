//
//  DayCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

import SnapKit

class DayCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let dateLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
    }
}

// MARK: - SetUp
private extension DayCollectionViewCell {
    func setUp() {
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(3)
        }
    }
}

// MARK: - Method
extension DayCollectionViewCell {
    func configure(with dayText: String) {
        dateLabel.text = dayText
    }
}
