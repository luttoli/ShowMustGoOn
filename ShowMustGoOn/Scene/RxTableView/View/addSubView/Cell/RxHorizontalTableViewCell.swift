//
//  RxHorizontalTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 1/10/25.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class RxHorizontalTableViewCell: UITableViewCell {
    // MARK: - Properties
    var disposeBag = DisposeBag()
    var timer: Timer? // 자동 스크롤 타이머
    
    // MARK: - Components
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HorizontalImageCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalImageCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0 // 총 페이지 개수
        pageControl.currentPage = 0 // 현재 활성화된 페이지 인덱스
        pageControl.pageIndicatorTintColor = .button.disabled // 비활성화 색상
        pageControl.currentPageIndicatorTintColor = .button.lavender // 활성화 색상
        pageControl.hidesForSinglePage = false // 페이지 하나일 시 숨길지 말지
        return pageControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        timer?.invalidate()
        timer = nil
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
    func configure(with images: [UIImage?]) {
        Observable.just(images)
            .bind(to: collectionView.rx.items(
                cellIdentifier: HorizontalImageCollectionViewCell.identifier,
                cellType: HorizontalImageCollectionViewCell.self
            )) { index, image, cell in
                cell.newsImageView.image = image
            }
            .disposed(by: disposeBag)

        pageControl.numberOfPages = images.count
        
        collectionView.rx.contentOffset
            .map { [weak self] offset -> Int in
                guard let self = self else { return 0 }
                let width = self.collectionView.bounds.width
                return width > 0 ? Int(round(offset.x / width)) : 0
            }
            .distinctUntilChanged()
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        startTimer()
    }

    private func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
    }

    @objc private func scrollToNext() {
        let currentOffset = collectionView.contentOffset.x
        let nextOffset = currentOffset + collectionView.bounds.width
        if nextOffset < collectionView.contentSize.width {
            collectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        } else {
            collectionView.setContentOffset(.zero, animated: false)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RxHorizontalTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
