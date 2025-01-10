//
//  RxHorizontalTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/10/25.
//

import UIKit

import RxCocoa
import RxSwift

class RxHorizontalTableViewCell: UITableViewCell {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = RxMixViewModel()
    
    // MARK: - Components
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    // 페이지 컨트롤 인디케이터
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0 // 총 페이지 개수
        pageControl.currentPage = 0 // 현재 활성화된 페이지 인덱스
        pageControl.pageIndicatorTintColor = .button.disabled // 비활성화 색상
        pageControl.currentPageIndicatorTintColor = .button.lavender // 활성화 색상
        pageControl.hidesForSinglePage = false // 페이지 하나일 시 숨길지 말지
        return pageControl
    }()
    
    // 자동 스크롤 타이머
    private var timer: Timer?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        startTimer()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension RxHorizontalTableViewCell {
    func setUp() {
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension RxHorizontalTableViewCell {
    func bindViewModel() {
        viewModel.tableViewData
            .map { $0.first?.mainImage ?? [] } // 첫 번째 MixModel의 이미지를 가져옴
            .bind(to: collectionView.rx.items(cellIdentifier: HorizontalCollectionViewCell.identifier, cellType: HorizontalCollectionViewCell.self)) { index, image, cell in
                cell.newsImageView.image = image
            }
            .disposed(by: disposeBag)
    }
    
    // 컬렉션 뷰 셀 전환 속도 조정
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollToNext() {
        let currentOffset = collectionView.contentOffset.x
        let nextOffset = currentOffset + collectionView.frame.width
        if nextOffset < collectionView.contentSize.width {
            collectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        } else {
            collectionView.setContentOffset(.zero, animated: true)
        }
    }
}
