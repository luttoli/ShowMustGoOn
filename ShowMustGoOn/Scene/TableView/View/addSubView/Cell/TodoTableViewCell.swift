//
//  TodoTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/19/24.
//

import UIKit

import SnapKit

class TodoTableViewCell: UITableViewCell {
    // MARK: - Components
    var title = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
    }
}

// MARK: - SetUp
private extension TodoTableViewCell {
    func setUp() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
        }
    }
}

// MARK: - Method
extension TodoTableViewCell {
    func configure(with model: TodoTableModel) {
        title.text = model.title
        title.textColor = model.isCompleted ? .text.lavender : .text.black
    }
}
