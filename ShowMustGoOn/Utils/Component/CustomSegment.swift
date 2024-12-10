//
//  CustomSegment.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/9/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class CustomSegment: UIView {
    // MARK: - Properties
    // 선택된 인덱스를 외부에 전달 (RxCocoa)
    let selectedIndex = PublishRelay<Int>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Components
    let segment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.selectedSegmentIndex = 0
        
        // 선택, 미선택 타이틀 설정
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.toPretendard(size: Constants.size.size15, weight: .Regular), .foregroundColor: UIColor.text.subDarkGray], for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.toPretendard(size: Constants.size.size15, weight: .SemiBold), .foregroundColor: UIColor.text.black], for: .selected)
        
        // 선택, 미선택 배경색 흰색 설정
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segment.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        
        // 구분선 흰색 설정
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        return segment
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .background.lavender
        return view
    }()
    
    // MARK: - Initializer
    init(items: [String]) {
        super.init(frame: .zero)
        setUp()
        configureSegments(items: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension CustomSegment {
    func setUp() {
        addSubview(segment)
        addSubview(bottomLineView)
        
        segment.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        segment.rx.selectedSegmentIndex
            .bind(to: selectedIndex)
            .disposed(by: disposeBag)
        
        // Rx로 선택 이벤트 처리
        segment.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] _ in
                self?.animateSegmentSelection()
                self?.updateBottomLinePosition(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // Configure
    func configureSegments(items: [String]) {
        segment.removeAllSegments()
        for (index, title) in items.enumerated() {
            segment.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        // 기본 선택
        segment.selectedSegmentIndex = 0
        updateBottomLinePosition(animated: false)
    }
}

// MARK: - Method
extension CustomSegment {
    // Bottom Line
    func updateBottomLinePosition(animated: Bool = true) {
        let selectedIndex = CGFloat(segment.selectedSegmentIndex)
        let segmentWidth = segment.bounds.width / CGFloat(segment.numberOfSegments)
        let lineHeight: CGFloat = 3
        
        let newFrame = CGRect(
            x: segmentWidth * selectedIndex,
            y: segment.frame.maxY - lineHeight,
            width: segmentWidth,
            height: lineHeight
        )
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.bottomLineView.frame = newFrame
            }
        } else {
            bottomLineView.frame = newFrame
        }
    }
    
    // Animation
    func animateSegmentSelection() {
        UIView.animate(withDuration: 0.2, animations: {
            self.segment.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.segment.transform = .identity
            }
        })
    }
}
