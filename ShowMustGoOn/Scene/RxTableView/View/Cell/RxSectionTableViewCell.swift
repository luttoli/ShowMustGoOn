//
//  RxSectionTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/19/24.
//

import UIKit

import SnapKit

class RxSectionTableViewCell: UITableViewCell {
    // MARK: - Components
    var numLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var titleLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numLabel.text = nil
        titleLabel.text = nil
    }
}

// MARK: - SetUp
private extension RxSectionTableViewCell {
    func setUp() {
        contentView.addSubview(numLabel)
        contentView.addSubview(titleLabel)
        
        numLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(numLabel.snp.trailing).offset(Constants.margin.horizontal)
        }
    }
}
