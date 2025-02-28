//
//  ChallengeListCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/26/25.
//

import UIKit

import SnapKit

class ChallengeListCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    var todoTitleLabel = CustomLabel(title: "TodoTitle", size: Constants.size.size15, weight: .SemiBold, color: .text.black)
    var yearLabel = CustomLabel(title: "25년\n02월", size: Constants.size.size15, weight: .SemiBold, color: .text.black)
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BlockCollectionViewCell.self, forCellWithReuseIdentifier: BlockCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        return collectionView
    }()
    
    var doneCountLabel = CustomLabel(title: "0일", size: Constants.size.size15, weight: .Regular, color: .text.black)
    var doneButton = CustomButton(type: .textButton(title: "완료", color: .lavender, size: .small))
    
    private lazy var doneStackView: UIStackView = {
        let doneStackView = UIStackView(arrangedSubviews: [doneCountLabel, doneButton])
        doneStackView.axis = .vertical
        doneStackView.distribution = .equalCentering
        doneStackView.alignment = .center
        doneStackView.spacing = Constants.spacing.px4
        return doneStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension ChallengeListCollectionViewCell {
    func setUp() {
        contentView.addSubview(todoTitleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(doneStackView)
        
        todoTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Constants.spacing.px12)
            $0.trailing.equalToSuperview().offset(-Constants.spacing.px12)
        }
        
        yearLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.spacing.px12)
            $0.centerY.equalTo(collectionView)
        }
        yearLabel.numberOfLines = 0
        yearLabel.textAlignment = .center
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(todoTitleLabel.snp.bottom).offset(Constants.spacing.px12)
            $0.leading.equalTo(yearLabel.snp.trailing).offset(Constants.spacing.px12)
            $0.trailing.equalTo(doneStackView.snp.leading).offset(-Constants.spacing.px12)
            $0.bottom.equalToSuperview().offset(-Constants.spacing.px12)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        doneStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Constants.spacing.px12)
            $0.centerY.equalTo(collectionView)
        }
    }
}

// MARK: - Method
extension ChallengeListCollectionViewCell {
    
}

// MARK: - UICollectionViewDelegate
extension ChallengeListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlockCollectionViewCell.identifier, for: indexPath) as? BlockCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.systemGray4
        cell.layer.cornerRadius = Constants.radius.px4
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 3
        let width = (collectionView.bounds.width - (spacing * 6)) / 7
        let height = (collectionView.bounds.height - (spacing * 5)) / 6
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
