//
//  DateCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

import SnapKit

class DateCollectionViewCell: UICollectionViewCell {
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
private extension DateCollectionViewCell {
    func setUp() {
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
}

// MARK: - Method
extension DateCollectionViewCell {
//    func configure(with text: String) {
//        keyPadLabel.text = text
//    }
}
