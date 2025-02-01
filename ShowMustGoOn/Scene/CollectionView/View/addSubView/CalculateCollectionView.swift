//
//  CalculateCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/28/25.
//

import UIKit

import SnapKit

class CalculateCollectionView: UIView {
    // MARK: - Properties
    let viewModel = CalculateCollectionViewModel()
    
    // MARK: - Components
    var calculateNumberLabel = CustomLabel(title: "0", size: Constants.size.size40, weight: .medium, color: .text.subDarkGray)
    
    var inputNumberLabel = CustomLabel(title: "0", size: Constants.size.size80, weight: .medium, color: .text.black)
    
    private lazy var numberStackView: UIStackView = {
        let numberStackView = UIStackView(arrangedSubviews: [calculateNumberLabel, inputNumberLabel])
        numberStackView.axis = .vertical
        numberStackView.spacing = 3
        numberStackView.alignment = .trailing
        return numberStackView
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
        collectionView.register(CalculateCollectionViewCell.self, forCellWithReuseIdentifier: CalculateCollectionViewCell.identifier)
        collectionView.backgroundColor = .background.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CalculateCollectionView {
    func setUp() {
        addSubview(numberStackView)
        addSubview(collectionView)
        
        numberStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(collectionView.snp.top)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(0.76)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension CalculateCollectionView {

}

// MARK: - delegate
extension CalculateCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.keypad.calculateNumberKey.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalculateCollectionViewCell.identifier, for: indexPath) as? CalculateCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = ((collectionView.bounds.width - (3 * 10)) / 4) / 2
        cell.backgroundColor = .background.lavender
        
        let key = viewModel.keypad.calculateNumberKey[indexPath.row]
        cell.configure(with: key)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 3 * 10
        let width = (collectionView.bounds.width - spacing) / 4

        return CGSize(width: width, height: width)
    }
    
    // 좌우
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
