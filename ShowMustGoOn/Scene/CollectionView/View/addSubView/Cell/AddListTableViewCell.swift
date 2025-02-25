//
//  AddListTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/25/25.
//

import UIKit

import SnapKit

class AddListTableViewCell: UITableViewCell {
    // MARK: - Components
    var mondayLabel = CustomLabel(title: "월", size: Constants.size.size12, weight: .Regular, color: .white)
    var wednesdayLabel = CustomLabel(title: "수", size: Constants.size.size12, weight: .Regular, color: .white)
    var fridayLabel = CustomLabel(title: "금", size: Constants.size.size12, weight: .Regular, color: .white)
    
    private lazy var dayLabelStackView: UIStackView = {
        let dayLabelStackView = UIStackView(arrangedSubviews: [mondayLabel, wednesdayLabel, fridayLabel])
        dayLabelStackView.axis = .vertical
        dayLabelStackView.distribution = .equalCentering
        dayLabelStackView.spacing = Constants.spacing.px20
        return dayLabelStackView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.identifier)
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // 고민좀 할듯
    var donCountLabel = CustomLabel(title: "0회 완료?", size: Constants.size.size15, weight: .Regular, color: .white)
    
    var donButton = CustomButton(type: .textButton(title: "완료", color: .lavender, size: .small))
    
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
private extension AddListTableViewCell {
    func setUp() {
        contentView.addSubview(dayLabelStackView)
        contentView.addSubview(collectionView)
        contentView.addSubview(donButton)
        
        dayLabelStackView.snp.makeConstraints {
            $0.leading.equalTo(Constants.spacing.px8)
            $0.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        donButton.snp.makeConstraints {
            $0.trailing.equalTo(-Constants.spacing.px8)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: - Method
extension AddListTableViewCell {
    
}

//
