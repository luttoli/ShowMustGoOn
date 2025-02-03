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
    var calculateLabel = CustomLabel(title: "0", size: Constants.size.size40, weight: .medium, color: .text.subDarkGray)
    
    var inputLabel = CustomLabel(title: "0", size: Constants.size.size80, weight: .medium, color: .text.black)
    
    private lazy var numberStackView: UIStackView = {
        let numberStackView = UIStackView(arrangedSubviews: [calculateLabel, inputLabel])
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
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let basicNumber = inputNumberLabel.text ?? ""
//        let keypad = viewModel.keypad.calculateNumberKey[indexPath.row]
//        
//        if keypad == "AC" {
//            inputLabel.text = "0"
//        } else {
//            if basicNumber == "0" {
//                inputLabel.text = keypad
//            } else {
//                inputLabel.text = basicNumber + keypad
//            }
//        }
//        
//        
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = viewModel.keypad.calculateNumberKey[indexPath.row]

        switch key {
        case "AC", "🧮":
            viewModel.currentInput = "0"
            viewModel.previousNumber = nil
            viewModel.selectedOperator = nil
            
        case "+", "-", "*", "/":
            // 연산자가 눌렸을 때
            if let prev = viewModel.previousNumber, let op = viewModel.selectedOperator {
                // 기존에 저장된 숫자와 연산자가 있으면 계산 먼저 수행
                viewModel.currentInput = viewModel.calculate(prev, op, viewModel.currentInput)
            }
            // 현재 입력값을 이전 숫자로 저장하고, 연산자 저장
            viewModel.previousNumber = viewModel.currentInput
            viewModel.selectedOperator = key
            viewModel.currentInput = "0"
            
        case "=":
            // 연산자가 있고, 이전 숫자가 있으면 계산 수행
            if let prev = viewModel.previousNumber, let op = viewModel.selectedOperator {
                viewModel.currentInput = viewModel.calculate(prev, op, viewModel.currentInput)
                viewModel.previousNumber = nil
                viewModel.selectedOperator = nil
            }
            
        default:
            // 숫자 입력 처리
            if viewModel.currentInput == "0" {
                viewModel.currentInput = key
            } else {
                viewModel.currentInput += key
            }
        }
        
        // UI 업데이트
        inputLabel.text = viewModel.currentInput
//        inputLabel.text = "\(viewModel.previousNumber ?? "") \(viewModel.selectedOperator ?? "") \(viewModel.currentInput)"
    }
}
