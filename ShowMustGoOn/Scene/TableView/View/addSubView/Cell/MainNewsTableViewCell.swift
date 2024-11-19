//
//  MainNewsTableViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/5/24.
//

import UIKit

import SnapKit

class MainNewsTableViewCell: UITableViewCell {
    // MARK: - Properties
    var viewModel = ThirdViewModel()
    
    // MARK: - Components
    let horizontalNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let horizontalNewsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalNewsCollectionView.register(HorizontalNewsCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalNewsCollectionViewCell.identifier)
        horizontalNewsCollectionView.backgroundColor = .clear
        horizontalNewsCollectionView.showsHorizontalScrollIndicator = false
        horizontalNewsCollectionView.isPagingEnabled = true
        return horizontalNewsCollectionView
    }()
    
    // 페이지 컨트롤 인디케이터
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .button.disabled
        pageControl.currentPageIndicatorTintColor = .button.lavender
        return pageControl
    }()
    
    // 자동 스크롤 타이머
    private var timer: Timer?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

// MARK: - SetUp
private extension MainNewsTableViewCell {
    func setUp() {
        contentView.addSubview(horizontalNewsCollectionView)
        contentView.addSubview(pageControl)
        
        horizontalNewsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        horizontalNewsCollectionView.delegate = self
        horizontalNewsCollectionView.dataSource = self
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

// MARK: - Method
extension MainNewsTableViewCell {
    // 컬렉션 뷰 셀 전환 속도 조정
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollToNext() {
        let currentOffset = horizontalNewsCollectionView.contentOffset.x
        let nextOffset = currentOffset + horizontalNewsCollectionView.frame.width
        if nextOffset < horizontalNewsCollectionView.contentSize.width {
            horizontalNewsCollectionView.setContentOffset(CGPoint(x: nextOffset, y: 0), animated: true)
        } else {
            horizontalNewsCollectionView.setContentOffset(.zero, animated: true)
        }
    }
}

// MARK: - CollectionViewDelegate
extension MainNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 페이지 컨트롤 인디케이터도 개수가 동일하여 여기서 설정
        let newImageCount = viewModel.eSportNews.first?.mainImage.count ?? 0
        pageControl.numberOfPages = newImageCount
        return newImageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalNewsCollectionViewCell.identifier, for: indexPath) as? HorizontalNewsCollectionViewCell else { return UICollectionViewCell() }
        
        let model = viewModel.eSportNews[0]
        cell.configure(with: model, at: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainNewsTableViewCell {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
