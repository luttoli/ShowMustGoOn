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
    weak var parentViewController: UIViewController? //
    
    var viewModel = BackMiracleCollectionViewModel()
    
    // MARK: - Components
    var nodataLabel = CustomLabel(title: "챌린지를 등록하세요!", size: Constants.size.size15, weight: .SemiBold, color: .text.black)
    
    var appTitleLabel = CustomLabel(title: "빽일의 기적", size: Constants.size.size20, weight: .SemiBold, color: .text.black)
    
    var addButtonIcon = CustomButton(type: .iconButton(icon: .plus))
    
    private lazy var titleHStackView: UIStackView = {
        let titleHStackView = UIStackView(arrangedSubviews: [appTitleLabel, addButtonIcon])
        titleHStackView.axis = .horizontal
        titleHStackView.spacing = 0
        titleHStackView.alignment = .center
        titleHStackView.distribution = .fill
        return titleHStackView
    }()

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
    
    var addButtonLarge = CustomButton(type: .textButton(title: "빽일의 기적 추가", color: .lavender, size: .large))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        hideOnLabel()
        didTapAddBackMiracleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension BackMiracleCollectionView {
    func setUp() {
        addSubview(nodataLabel)
        addSubview(titleHStackView)
        addSubview(collectionView)
        addSubview(addButtonLarge)
        
        nodataLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        titleHStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(appTitleLabel.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addButtonLarge.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(Constants.margin.vertical)
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
    
    // 추가하기 버튼 액션
    func didTapAddBackMiracleButton() {
        addButtonIcon.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.presentAddBackMiracleVC()
        }), for: .touchUpInside)
        
        addButtonLarge.addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            self.presentAddBackMiracleVC()
        }), for: .touchUpInside)
    }
    
    // 모달 띠우는 함수
    private func presentAddBackMiracleVC() {
        let addBackMiracleVC = AddBackMiracleViewController()
        let navController = UINavigationController(rootViewController: addBackMiracleVC)

        //모달 크기 미디움
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true //Grabber 노출 설정
        }
//            self.present(addBackMiracleVC, animated: true) // view라서 뷰컨 기능 권한 넘기기?
        self.parentViewController?.present(navController, animated: true)
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
