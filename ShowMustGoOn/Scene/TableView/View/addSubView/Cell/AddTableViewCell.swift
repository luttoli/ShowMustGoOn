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
    var checkItemTitle = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var checkItemCheckboxButton = CustomButton(type: .iconButton(icon: .checkBox))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkItemTitle.text = nil
        checkItemCheckboxButton.isChecked = false
        checkItemCheckboxButton.setImage(CustomButton.ButtonType.IconType.checkBox.image, for: .normal)
    }
}

// MARK: - SetUp
private extension AddTableViewCell {
    func setUp() {
        contentView.addSubview(checkItemTitle)
        contentView.addSubview(checkItemCheckboxButton)
        
        checkItemTitle.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(Constants.spacing.px8)
            $0.trailing.equalTo(checkItemCheckboxButton.snp.leading).offset(-Constants.spacing.px10)
        }
        checkItemTitle.numberOfLines = 1
        
        checkItemCheckboxButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView)
        }
    }
}

// MARK: - Method
extension AddTableViewCell {
    func configure(with checkItem: CheckItem) {
        checkItemTitle.text = checkItem.checkItemTitle
        
        // item.isChecked 값에 따라 텍스트 색상, 이미지 교체
        checkItemTitle.textColor = checkItem.isChecked ? .text.lavender : .text.black
        checkItemCheckboxButton.toggleButton(isChecked: checkItem.isChecked, icon: .checkBox)
    }
}
