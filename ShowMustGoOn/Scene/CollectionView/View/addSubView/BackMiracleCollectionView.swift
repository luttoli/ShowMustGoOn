//
//  BackMiracleCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/27/25.
//

import UIKit

import SnapKit

class BackMiracleCollectionView: UIView {
    // MARK: - Properties
    var viewModel = BackMiracleCollectionViewModel()
    
    // MARK: - Components
    var nodataLabel = CustomLabel(title: "챌린지를 등록하세요!", size: Constants.size.size15, weight: .SemiBold, color: .text.black)
    
    var appTitleLabel = CustomLabel(title: "빽일의 기적", size: Constants.size.size20, weight: .SemiBold, color: .text.black)
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BackMiracleListCollectionViewCell.self, forCellWithReuseIdentifier: BackMiracleListCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var addBackMiracleButton = CustomButton(type: .textButton(title: "기적 생성하기", color: .lavender, size: .large))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        hideOnLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension BackMiracleCollectionView {
    func setUp() {
        addSubview(nodataLabel)
        addSubview(appTitleLabel)
        addSubview(collectionView)
        addSubview(addBackMiracleButton)
        
        nodataLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        appTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(Constants.spacing.px20)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addBackMiracleButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(Constants.spacing.px10)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension BackMiracleCollectionView {
    // 챌린지 없는 경우 라벨 숨기기
    func hideOnLabel() {
        nodataLabel.isHidden = !viewModel.backMiracles.isEmpty
    }
}

// MARK: - UICollectionViewDelegate
extension BackMiracleCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
        return viewModel.backMiracles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackMiracleListCollectionViewCell.identifier, for: indexPath) as? BackMiracleListCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .clear
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = Constants.radius.px8
        
        
        let backMiracle = viewModel.backMiracles[indexPath.row]
        cell.backMiracleTitleLabel.text = backMiracle.title
        cell.yearLabel.text = viewModel.yearLabelText
        cell.dayNumberLabel.text = "100일차"
//        cell.doneCountLabel.text = "\(viewModel.doneCount)일 완료"
        cell.doneCountLabel.text = "100일 완료"
        
        cell.backMiracle = backMiracle // 데이터를 안에 콜랙션뷰셀에 있는 콜랙션뷰로 넘겨줌
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: Constants.size.size200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing.px14
    }
}
