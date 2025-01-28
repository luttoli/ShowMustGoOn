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
        tagCollectionView.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
        tagCollectionView.backgroundColor = .clear
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.showsVerticalScrollIndicator = false
        return tagCollectionView
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
private extension SelectCollectionView {
    func setUp() {
        addSubview(tagCollectionView)

        
        tagCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(safeAreaLayoutGuide)
        }
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        

    }
}

// MARK: - Method
extension SelectCollectionView {

}

// MARK: - delegate
extension SelectCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as? SelectCollectionViewCell else { return UICollectionViewCell() }
        
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.backgroundColor = .button.lightGray
        cell.configure(with: viewModel.ingredients[indexPath.row])
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
}

// MARK: - LeftAlignedFlowLayout 좌우 정렬
class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        // 현재 줄의 X 오프셋과 초기화된 값
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        for layoutAttribute in attributes {
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
