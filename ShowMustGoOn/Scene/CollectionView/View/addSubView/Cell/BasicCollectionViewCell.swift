//
//  BasicCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/24/25.
//

import UIKit

import SnapKit

class BasicCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let textLabel = CustomLabel(title: "", size: 20, weight: .Regular, color: .text.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension BasicCollectionViewCell {
    func setUp() {
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension BasicCollectionViewCell {
    func configure(with text: String) {
        textLabel.text = text
    }
}
