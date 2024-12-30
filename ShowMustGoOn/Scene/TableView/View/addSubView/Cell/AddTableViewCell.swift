//
//  AddTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

import SnapKit

class AddTableViewCell: UITableViewCell {
    // MARK: - Components
    var itemTitle = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var checkBoxButton = CustomButton(type: .iconButton(icon: .checkBox))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemTitle.text = nil
        checkBoxButton.isChecked = false
        checkBoxButton.setImage(CustomButton.ButtonType.IconType.checkBox.image, for: .normal)
    }
}

// MARK: - SetUp
private extension AddTableViewCell {
    func setUp() {
        contentView.addSubview(itemTitle)
        contentView.addSubview(checkBoxButton)
        
        itemTitle.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(Constants.spacing.px8)
            $0.trailing.equalTo(checkBoxButton.snp.leading).offset(-Constants.spacing.px10)
        }
        itemTitle.numberOfLines = 1
        
        checkBoxButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView)
        }
    }
}

// MARK: - Method
extension AddTableViewCell {
    func configure(with item: Item) {
        itemTitle.text = item.title
        
        // item.isChecked 값에 따라 텍스트 색상, 이미지 교체
        itemTitle.textColor = item.isChecked ? .text.lavender : .text.black
        checkBoxButton.toggleButton(isChecked: item.isChecked, icon: .checkBox)
    }
}
