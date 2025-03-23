//
//  RxBasicCollectionView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/23/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxBasicCollectionView: UIView {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxBasicCollectionViewModel()
    
    // MARK: - Components
    var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPrefetchingEnabled = true
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        collectionView.backgroundColor = .red
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.refreshControl = UIRefreshControl()
        return collectionView
    }()
    
    var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPrefetchingEnabled = true
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        collectionView.backgroundColor = .blue
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        bindCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension RxBasicCollectionView {
    func setUp() {
        addSubview(verticalCollectionView)
        addSubview(horizontalCollectionView)
        
        verticalCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.5)
        }
        
        horizontalCollectionView.snp.makeConstraints {
            $0.top.equalTo(verticalCollectionView.snp.bottom)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        // Rx로 바인딩하더라도 delegate 메서드를 사용하기 위해 delegate 연결
        verticalCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        horizontalCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

// MARK: - Method
extension RxBasicCollectionView {
    func bindCollectionView() {
        viewModel.data
            .bind(to: verticalCollectionView.rx.items(cellIdentifier: BasicCollectionViewCell.identifier)) { index, model, cell in
                guard let cell = cell as? BasicCollectionViewCell else { return }
                cell.textLabel.text = model.number.first ?? ""
            }
            .disposed(by: disposeBag)
        
        viewModel.data
            .bind(to: horizontalCollectionView.rx.items(cellIdentifier: BasicCollectionViewCell.identifier)) { index, model, cell in
                guard let cell = cell as? BasicCollectionViewCell else { return }
                cell.textLabel.text = model.number.first ?? ""
            }
            .disposed(by: disposeBag)
        
        verticalCollectionView.rx.modelSelected(BasicCollectionModel.self)
            .subscribe(onNext: { model in
                print("\(model.number)")
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RxBasicCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 1 * 2
        
        if collectionView == verticalCollectionView {
            let width = (collectionView.bounds.width - spacing) / 3
            return CGSize(width: width, height: width)
        } else {
            let width = (collectionView.bounds.height - spacing) / 3
            return CGSize(width: width, height: width)
        }
    }
    
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 상하 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
