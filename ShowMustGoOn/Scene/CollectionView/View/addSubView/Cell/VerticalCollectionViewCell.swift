//
//  VerticalCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

import SnapKit

class VerticalCollectionViewCell: UICollectionViewCell {
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
private extension VerticalCollectionViewCell {
    func setUp() {
        contentView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension VerticalCollectionViewCell {
    
}
