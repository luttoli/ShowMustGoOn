//
//  SelectCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/28/25.
//

import UIKit

import SnapKit

class SelectCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let textLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension SelectCollectionViewCell {
    func setUp() {
        contentView.addSubview(textLabel)

        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension SelectCollectionViewCell {
    func configure(with model: SelectCollectionModel) {
        textLabel.text = model.menuTitle
    }
}
