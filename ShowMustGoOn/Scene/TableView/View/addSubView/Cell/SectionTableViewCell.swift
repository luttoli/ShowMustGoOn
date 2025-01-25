//
//  SectionTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/1/24.
//

import UIKit

import SnapKit

class SectionTableViewCell: UITableViewCell {
    // MARK: - Components
    var frontNumberLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var asterisk = CustomLabel(title: "x", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var backNumberLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var equalSign = CustomLabel(title: "=", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var resultNumberLabel = CustomLabel(title: "", size: Constants.size.size15, weight: .Regular, color: .text.black)
    
    private lazy var multiplyHorizontalStackView: UIStackView = {
        let multiplyHorizontalStackView = UIStackView(arrangedSubviews: [frontNumberLabel, asterisk, backNumberLabel, equalSign, resultNumberLabel])
        multiplyHorizontalStackView.axis = .horizontal
        multiplyHorizontalStackView.spacing = Constants.spacing.px10
        multiplyHorizontalStackView.alignment = .center
        return multiplyHorizontalStackView
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
private extension SectionTableViewCell {
    func setUp() {
        contentView.addSubview(multiplyHorizontalStackView)
        
        multiplyHorizontalStackView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.margin.horizontal)
        }
    }
}

// MARK: - Method
extension SectionTableViewCell {
    func configure(with model: SectionTableModel) {
        frontNumberLabel.text = "\(model.frontNumber)"
        backNumberLabel.text = "\(model.backNumber)"
        resultNumberLabel.text = model.showResult ? "\(model.resultNumber)" : "?"
    }
}
