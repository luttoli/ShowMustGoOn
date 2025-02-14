//
//  DateCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

import SnapKit

class CalendarDateCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let dateLabel = CustomLabel(title: "", size: Constants.size.size12, weight: .Regular, color: .text.black)
    
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
private extension CalendarDateCollectionViewCell {
    func setUp() {
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(1)
        }
    }
}

// MARK: - Method
extension CalendarDateCollectionViewCell {
//    func configure(with text: String) {
//        keyPadLabel.text = text
//    }
}
