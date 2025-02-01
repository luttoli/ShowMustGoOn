//
//  CalculateCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/31/25.
//

import UIKit

import SnapKit

class CalculateCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let keyPadLabel = CustomLabel(title: "", size: Constants.size.size30, weight: .Regular, color: .text.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        keyPadLabel.text = nil
    }
}

// MARK: - SetUp
private extension CalculateCollectionViewCell {
    func setUp() {
        contentView.addSubview(keyPadLabel)
        
        keyPadLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension CalculateCollectionViewCell {
    func configure(with text: String) {
        keyPadLabel.text = text
    }
}
