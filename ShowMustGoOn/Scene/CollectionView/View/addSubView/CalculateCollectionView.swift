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
    var calculateLabel = CustomLabel(title: "", size: Constants.size.size30, weight: .medium, color: .text.subDarkGray)
    
    var inputLabel = CustomLabel(title: "0", size: Constants.size.size70, weight: .medium, color: .text.black)
    
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
        return viewModel.keypad.calculateKey.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalculateCollectionViewCell.identifier, for: indexPath) as? CalculateCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = ((collectionView.bounds.width - (3 * 10)) / 4) / 2
        cell.backgroundColor = .background.lavender
        
        let key = viewModel.keypad.calculateKey[indexPath.row]
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
        let keypads = viewModel.keypad.calculateKey[indexPath.item]
        
        switch keypads {
        case "AC", "🧮":
            inputLabel.text = "0"
            calculateLabel.text = ""
            
        case "⌫": // 백스페이스 버튼 기능 추가
            if let text = inputLabel.text, !text.isEmpty {
                inputLabel.text = String(text.dropLast()) // 마지막 문자 제거
            }
            if inputLabel.text?.isEmpty == true {
                inputLabel.text = "0" // 텍스트가 다 지워지면 "0"으로 초기화
            }
            
        case "+", "-", "*", "/", "%": // 연산자 처리
            if let text = inputLabel.text, !text.isEmpty {
                if let lastChar = text.last, "+-*/%".contains(lastChar) {
                    // 마지막 문자가 연산자라면 현재 연산자로 교체
                    inputLabel.text = String(text.dropLast()) + keypads
                } else {
                    // 마지막 문자가 숫자라면 연산자 추가
                    inputLabel.text! += keypads
                }
            }
            
        case "=":
            if let text = inputLabel.text, !text.isEmpty {
                if let lastChar = text.last, "+-*/%.".contains(lastChar) {
                    // 마지막 문자가 연산자, . 상태서 = 클릭하면 미동작
                } else {
                    let result = viewModel.calculation(text)
                    calculateLabel.text = text // 입력한 계산 수식 표시
                    inputLabel.text = result // 계산 결과값 표시
                }
            }
            
        default:
            if inputLabel.text == "0" {
                inputLabel.text = keypads
            } else {
                inputLabel.text! += keypads
            }
        }
    }
}
