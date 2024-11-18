//
//  MemoTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/18/24.
//

import UIKit

import SnapKit

class MemoTableViewCell: UITableViewCell {
    // MARK: - Components
    var itemTitle = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        return switchButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension MemoTableViewCell {
    func setUp() {
        contentView.addSubview(itemTitle)
        contentView.addSubview(switchButton)
        
        itemTitle.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(Constants.spacing.px8)
            $0.trailing.equalTo(switchButton.snp.leading).offset(-Constants.spacing.px10)
        }
        
        switchButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView)
        }
    }
}

// MARK: - Method
extension MemoTableViewCell {
//    func configure(with model: TableModel) {
//        numLabel.text = "\(model.number)."
//        titleLabel.text = model.title
//    }
}
