//
//  CalendarCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

import SnapKit

class CalendarCollectionView: UIView {
    // MARK: - Properties
    
    
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
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
        collectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        configureDayLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CalendarCollectionView {
    func setUp() {
        addSubview(yearLabel)
        addSubview(dayStackView)
        addSubview(collectionView)
        
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
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension CalendarCollectionView {
    func configureDayLabel() {
        let dayOfTheWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
        
        for i in 0..<7 {
            let label = CustomLabel(title: dayOfTheWeek[i], size: Constants.size.size20, weight: .medium, color: .text.black)
            label.textAlignment = .center
            
            if i == 0 {
                label.textColor = .text.notification.red
            } else if i == 6 {
                label.textColor = .text.lavender
            } else {
                label.textColor = .text.black
            }
            
            self.dayStackView.addArrangedSubview(label)
        }
    }
}

// MARK: - delegate
extension CalendarCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.identifier, for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
