//
//  VerticalCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

import SnapKit

class BasicCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .background.lavender
        return view
    }()
    
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
        contentView.addSubview(colorView)
        contentView.addSubview(textLabel)
        
        colorView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension BasicCollectionViewCell {
    func configure(with model: BasicCollectionModel) {
        textLabel.text = model.number
    }
}
