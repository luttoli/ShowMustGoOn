//
//  CalendarCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/9/25.
//

import UIKit

import SnapKit

class CalendarCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    var yearLabel = CustomLabel(title: "25년 2월", size: Constants.size.size20, weight: .medium, color: .text.black)
    
    private lazy var dayStackView: UIStackView = {
        let numberStackView = UIStackView()
        numberStackView.axis = .horizontal
        numberStackView.distribution = .fillEqually
        numberStackView.alignment = .center
        return numberStackView
    }()

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
        configureDayLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension CalendarCollectionViewCell {
    func setUp() {
        contentView.addSubview(yearLabel)
        contentView.addSubview(dayStackView)
        contentView.addSubview(collectionView)
        
        yearLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing.px10)
            $0.leading.equalToSuperview()
        }
        
        dayStackView.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom).offset(Constants.spacing.px20)
            $0.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(dayStackView.snp.bottom).offset(Constants.spacing.px20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension CalendarCollectionViewCell {
    func configureDayLabel() {
        let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size20, weight: .medium, color: .text.black)
            label.textAlignment = .center
            
            if i == 0 {
                label.textColor = .text.lavender
            } else if i == 6 {
                label.textColor = .text.subDarkGray
            } else {
                label.textColor = .text.black
            }
            
            self.dayStackView.addArrangedSubview(label)
        }
    }
}

// MARK: - CollectionViewDelegate
extension CalendarCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as? DateCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.black.cgColor
        
        cell.dateLabel.text = "0"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 1
        let width = (collectionView.bounds.width - (spacing * 6)) / 7
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
