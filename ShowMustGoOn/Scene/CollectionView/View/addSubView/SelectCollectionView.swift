//
//  SelectCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/26/25.
//

import UIKit

import SnapKit

class SelectCollectionView: UIView {
    // MARK: - Properties
    let viewModel = SelectCollectionViewModel()
    
    // MARK: - Components
    var tagCollectionView: UICollectionView = {
        let layout = LeftAlignedFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagCollectionView.isPrefetchingEnabled = true
        tagCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "header")
        tagCollectionView.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
        tagCollectionView.backgroundColor = .clear
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.showsVerticalScrollIndicator = false
        return tagCollectionView
    }()
    
    var selectedIngredientLabel = CustomLabel(title: "선택한 재료: 없음", size: Constants.size.size12, weight: .Regular, color: .text.lavender)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension SelectCollectionView {
    func setUp() {
        addSubview(tagCollectionView)
        addSubview(selectedIngredientLabel)
        
        tagCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(selectedIngredientLabel.snp.top).offset(-10)
        }
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        selectedIngredientLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Method
extension SelectCollectionView {

}

// MARK: - delegate
extension SelectCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // 재사용 가능한 헤더 뷰 생성
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "header", for: indexPath)
            
            header.subviews.forEach { $0.removeFromSuperview() } // 기존 서브뷰 제거 (중복 추가 방지)
            
            let titleLabel = UILabel()
            titleLabel.text = "재료 선택"
            titleLabel.font = UIFont.toPretendard(size: Constants.size.size18, weight: .Regular)
            titleLabel.textColor = .black
            
            header.addSubview(titleLabel)
            titleLabel.snp.makeConstraints {
                $0.leading.top.equalToSuperview()
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.size.size40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // 셀 기본 초기화
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.configure(with: viewModel.ingredients[indexPath.row])
        
        // 선택 여부에 따라 셀 스타일 업데이트
        if viewModel.selectIndexPath.contains(indexPath) {
            cell.backgroundColor = .cell.lavender
            cell.textLabel.textColor = .text.white
        } else {
            cell.backgroundColor = .cell.lightGray
            cell.textLabel.textColor = .text.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = viewModel.ingredients[indexPath.row]
        let text = model.menuTitle
        
        // 임시 UILabel 생성 후 텍스트 길이 계산
        let label = UILabel()
        label.font = UIFont.toPretendard(size: Constants.size.size15, weight: .Regular)
        label.text = text
        let textSize = label.intrinsicContentSize
        
        // 텍스트 크기에 패딩 추가
        var width = textSize.width + 26
        let height = textSize.height + 20
        
        if text.count == 1 {
            width += 10
        }
        return CGSize(width: width, height: height)
    }
    
    // 좌우
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // 상하
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SelectCollectionViewCell else { return }
        
        if let selectedIndex = viewModel.selectIndexPath.firstIndex(of: indexPath) {
            viewModel.selectIndexPath.remove(at: selectedIndex)
            viewModel.selectIngredient.remove(at: selectedIndex)
            cell.backgroundColor = .cell.lightGray
            cell.textLabel.textColor = .text.black
            selectedIngredientLabel.text = "선택한 재료: \(viewModel.selectIngredient.joined(separator: ", "))"
            if viewModel.selectIngredient.isEmpty {
                selectedIngredientLabel.text = "선택한 재료: 없음"
            }
        } else {
            viewModel.selectIndexPath.append(indexPath)
            let selectedIngredient = viewModel.ingredients[indexPath.row].menuTitle
            viewModel.selectIngredient.append(selectedIngredient)
            cell.backgroundColor = .cell.lavender
            cell.textLabel.textColor = .text.white
            selectedIngredientLabel.text = "선택한 재료: \(viewModel.selectIngredient.joined(separator: ", "))"
        }
    }
}

// MARK: - LeftAlignedFlowLayout 좌우 정렬
class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        // 현재 줄의 X 오프셋과 초기화된 값
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        for layoutAttribute in attributes {
            // 헤더나 풋터는 위치 조정을 하지 않음
            if layoutAttribute.representedElementKind == UICollectionView.elementKindSectionHeader ||
               layoutAttribute.representedElementKind == UICollectionView.elementKindSectionFooter {
                continue
            }

            // 동일한 줄의 아이템은 정렬
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
