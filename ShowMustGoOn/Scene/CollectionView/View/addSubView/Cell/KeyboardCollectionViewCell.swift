//
//  KeyboardCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/24/25.
//

import UIKit

import SnapKit

class KeyboardCollectionViewCell: UICollectionViewCell {
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
private extension KeyboardCollectionViewCell {
    func setUp() {
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension KeyboardCollectionViewCell {
    func configure(with text: String) {
        textLabel.text = text
    }
}
