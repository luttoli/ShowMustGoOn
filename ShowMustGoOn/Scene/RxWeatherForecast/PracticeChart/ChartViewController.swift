//
//  ChartViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/11/25.
//

import UIKit

import SnapKit

class ChartViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    let segment = CustomSegment(items: ["바차트", "점차트", "원차트"])
    let barChartView = BarChartView()
    let dotChartView = DotChartView()
    let circleChartView = CircleChartView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension ChartViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        segmentClickEvent()
        segment.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 세그먼트 인덱스 초기화
        segment.segment.selectedSegmentIndex = 0
        segment.updateBottomLinePosition()
        
        // 초기화된 세그먼트 인덱스에 맞는 화면 업데이트
        segment.selectedIndex.accept(0)
    }
}

// MARK: - Navigation
extension ChartViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let titleLabel = UILabel()
        titleLabel.text = "Chart"
        titleLabel.font = UIFont.toPretendard(size: Constants.size.size18, weight: .medium)
        titleLabel.textColor = .text.black
        titleLabel.textAlignment = .center
        
        self.navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - SetUp
private extension ChartViewController {
    func setUp() {
        view.addSubview(segment)
        view.addSubview(barChartView)
        view.addSubview(dotChartView)
        view.addSubview(circleChartView)
        
        segment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        dotChartView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        circleChartView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
    }
}

// MARK: - Method
private extension ChartViewController {
    func segmentClickEvent() {
        segment.selectedIndex
            .subscribe(onNext: { index in
                // 모든 뷰 숨김 처리
                let segmentView = [self.barChartView, self.dotChartView, self.circleChartView]
                segmentView.forEach { $0.isHidden = true }
                
                // 선택된 세그먼트에 따라 해당 뷰만 보이게
                switch index {
                case 0:
                    self.barChartView.isHidden = false
                case 1:
                    self.dotChartView.isHidden = false
                case 2:
                    self.circleChartView.isHidden = false
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension ChartViewController {
    
}
