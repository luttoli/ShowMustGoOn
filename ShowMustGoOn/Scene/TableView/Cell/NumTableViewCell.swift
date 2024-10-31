//
//  NumTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/23/24.
//

import UIKit

import SnapKit

class NumTableViewCell: UITableViewCell {
    // MARK: - Components
    var numLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
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
private extension NumTableViewCell {
    func setUp() {
        contentView.addSubview(numLabel)
        
        numLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
        }
    }
}

// MARK: - Method
extension NumTableViewCell {

}
