//
//  KeyboardCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/26/25.
//

import UIKit

class KeyboardCollectionView: UIView {
    // MARK: - Properties
    private let viewModel = KeyboardCollectionViewModel()
    
    // MARK: - Components
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "여기에 입력하세요."
        textField.borderStyle = .roundedRect
        textField.font = .toPretendard(size: Constants.size.size25, weight: .Regular)
        textField.backgroundColor = .systemBackground
        textField.textColor = .text.black
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemGray6
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
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
private extension KeyboardCollectionView {
    func setUp() {
        addSubview(textField)
        addSubview(collectionView)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Constants.size.size50)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(Constants.size.size20)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.size.size20)
            $0.height.equalTo(Constants.size.size70)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Constants.size.size50)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Method
extension KeyboardCollectionView {

}

// MARK: - delegate
extension KeyboardCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.keys[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCollectionViewCell.identifier, for: indexPath) as? KeyboardCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = Constants.radius.px4
        
        let key = viewModel.keys[indexPath.section][indexPath.row]
        cell.configure(with: key)
        
        if key == "^" || key == "⌫" {
            cell.backgroundColor = .systemGray4
        } else {
            cell.backgroundColor = .background.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 9 * 5
        let width = (collectionView.bounds.width - spacing) / 10.5

        if indexPath.section == 3 {
            return CGSize(width: width * 5 + (5 * 6), height: width + 10)
        } else {
            return CGSize(width: width, height: width + 10)
        }
    }
    
    // 좌우
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = viewModel.keys[indexPath.section][indexPath.row]
        
        if key == "⌫" {
            if let text = textField.text, !text.isEmpty {
                textField.text = String(text.dropLast())
            }
        } else if key == "스페이스" {
            textField.text = (textField.text ?? "") + " "
        } else {
            textField.text = (textField.text ?? "") + key
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 섹션별 여백 조정
        switch section {
        case 0:
            return UIEdgeInsets(top: 5, left: 3, bottom: 0, right: 3)
        case 1:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case 2:
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        case 3:
            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        default:
            return UIEdgeInsets.zero
        }
    }
}
