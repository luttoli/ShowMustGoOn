//
//  TableSegmentView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/31/24.
//

import UIKit

import SnapKit

class TableSegmentView: UIView {
    // MARK: - Components
    var tableSegment: UISegmentedControl = {
        let tableSegment = UISegmentedControl(items: ["기본", "섹션", "혼합", "추가", "응용"])
        tableSegment.selectedSegmentIndex = 0
        
        // 선택, 미선택 타이틀설정
        tableSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.toPretendard(size: Constants.size.size15, weight: .Regular), .foregroundColor: UIColor.text.subDarkGray], for: .normal)
        tableSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.toPretendard(size: Constants.size.size15, weight: .SemiBold), .foregroundColor: UIColor.text.black], for: .selected)
        
        // 배경색 설정
        tableSegment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default) // 배경색 변경
        tableSegment.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default) // 선택된 색 변경 -> 흰색
        
        // 구분선 설정
        tableSegment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default) // 구분선 흰색
        return tableSegment
    }()
    
    // 선택한 세그먼트 바텀라인
    var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .button.lavender
        return view
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
private extension TableSegmentView {
    func setUp() {
        addSubview(tableSegment)
        addSubview(bottomLineView)
        
        tableSegment.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Method
extension TableSegmentView {
    // 세그먼트 선택 애니메이션 메서드
    func animateSelectedSegment() {
        UIView.animate(withDuration: 0.3) {
            self.tableSegment.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.tableSegment.transform = CGAffineTransform.identity
            }
        }
    }
    
    // 세그먼트 바텀라인 업데이트 메서드
    func updateBottomLinePosition() {
        let selectedSegmentIndex = tableSegment.selectedSegmentIndex
        let segmentWidth = tableSegment.bounds.width / CGFloat(tableSegment.numberOfSegments)
        let lineHeight: CGFloat = 3 // 바텀 라인의 높이
        
        UIView.animate(withDuration: 0.3) {
            self.bottomLineView.frame = CGRect(
                x: CGFloat(selectedSegmentIndex) * segmentWidth,
                y: self.tableSegment.frame.maxY - lineHeight,
                width: segmentWidth,
                height: lineHeight
            )
        }
    }
}
