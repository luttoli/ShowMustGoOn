//
//  TableViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

import SnapKit

class TableViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Components
    var tableSegment: UISegmentedControl = {
        let tableSegment = UISegmentedControl(items: ["기본", "섹션", "혼합", "추가"])
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
    
    var firstView = FirstView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateBottomLinePosition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableSegment.selectedSegmentIndex = 0
        updateBottomLinePosition()
        changeView()
    }
}

// MARK: - Navigation
extension TableViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "TableView Practice", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension TableViewController {
    func setUp() {
        view.addSubview(tableSegment)
        view.addSubview(bottomLineView)
        view.addSubview(firstView)
        
        tableSegment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        tableSegment.addAction(UIAction(handler: { [weak self] _ in // combine 연습하기
            guard let self = self else { return }
            self.animateSelectedSegment(segment: self.tableSegment)
            self.updateBottomLinePosition()
            self.changeView()
        }), for: .valueChanged)
        
        firstView.snp.makeConstraints {
            $0.top.equalTo(tableSegment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        changeView()
    }
}

// MARK: - Method
private extension TableViewController {
    // 세그먼트 선택 시 애니메이션
    func animateSelectedSegment(segment: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            segment.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                segment.transform = CGAffineTransform.identity
            }
        }
    }
    
    // 선택된 세그먼트 바텀라인 표시
    private func updateBottomLinePosition() {
        let selectedSegmentIndex = tableSegment.selectedSegmentIndex
        let segmentWidth = tableSegment.bounds.width / CGFloat(tableSegment.numberOfSegments)
        let lineHeight: CGFloat = 3 // 바텀 라인의 높이

        UIView.animate(withDuration: 0.3) {
            self.bottomLineView.frame = CGRect(
                x: CGFloat(selectedSegmentIndex) * segmentWidth + Constants.margin.horizontal,
                y: self.tableSegment.frame.maxY - lineHeight,
                width: segmentWidth,
                height: lineHeight
            )
        }
    }
    
    // 세그먼트 선택 시 View 노출
    func changeView() {
        // 모든 뷰 숨김 처리 했다가
        let segmentView = [firstView, ]
        segmentView.forEach { $0.isHidden = true }
        
        // 선택된 세그먼트에 따라 해당 뷰만 보이게
        switch tableSegment.selectedSegmentIndex {
        case 0:
            firstView.isHidden = false
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
}
