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
    var checkBoxButton = CustomButton(type: .iconButton(icon: .checkBox))
    
    //
    private var isChecked: Bool = false {
        didSet {
            // 상태가 변경되면 버튼 이미지 업데이트
            let checkBoxImage = isChecked ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
            checkBoxButton.setImage(checkBoxImage, for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 재사용 시 초기화
        isChecked = false
    }
}

// MARK: - SetUp
private extension MemoTableViewCell {
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
    
    //
    func addActions() {
        // 체크박스 버튼에 액션 추가
        checkBoxButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.isChecked.toggle() // 상태 변경
        }, for: .touchUpInside)
    }
}

// MARK: - Method
extension MemoTableViewCell {
    //
    func configure(with item: Item) {
        itemTitle.text = item.title
        isChecked = item.isChecked
    }
}
