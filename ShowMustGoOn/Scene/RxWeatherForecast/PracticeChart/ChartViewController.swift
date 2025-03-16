//
//  ChartViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/11/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class ChartViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
//    let segment = CustomSegment(items: ["바차트", "점차트", "원차트", "선차트", "뭔차트"])
    let segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["바차트", "점차트", "원차트", "선차트", "뭔차트"])
        segment.selectedSegmentIndex = 0
        
        return segment
    }()
    var barChartView = BarChartView()
    var dotChartView = DotChartView()
    var circleChartView = CircleChartView()
    var lineChartView = LineChartView()
    var semiCircleView = SemiCircleView()
    
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
//        segment.segment.selectedSegmentIndex = 0
//        segment.updateBottomLinePosition()
        
        // 초기화된 세그먼트 인덱스에 맞는 화면 업데이트
//        segment.selectedIndex.accept(0)
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
        view.addSubview(lineChartView)
        view.addSubview(semiCircleView)
        
        let chartViews = [dotChartView, circleChartView, lineChartView, semiCircleView]

        for chartView in chartViews {
            chartView.isHidden = true
        }
        
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
        
        lineChartView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        semiCircleView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
    }
}

// MARK: - Method
private extension ChartViewController {
//    func segmentClickEvent() {
//        segment.selectedIndex
//            .subscribe(onNext: { index in
//                // 모든 뷰 숨김 처리
//                let segmentView = [self.barChartView, self.dotChartView, self.circleChartView, self.lineChartView, self.semiCircleView]
//                segmentView.forEach { $0.isHidden = true }
//                
//                // 선택된 세그먼트에 따라 해당 뷰만 보이게
//                switch index {
//                case 0:
//                    self.barChartView.isHidden = false
//                case 1:
//                    self.dotChartView.isHidden = false
//                case 2:
//                    self.circleChartView.isHidden = false
//                case 3:
//                    self.lineChartView.isHidden = false
//                case 4:
//                    self.semiCircleView.isHidden = false
//                default:
//                    break
//                }
//            })
//            .disposed(by: disposeBag)
//    }
    func segmentClickEvent() {
        segment.addAction(UIAction(handler: { [weak self] _ in
            self?.changeView()
        }), for: .valueChanged)
    }
    
    func changeView() {
        let chartViews = [barChartView, dotChartView, circleChartView, lineChartView, semiCircleView]
        chartViews.forEach { $0.isHidden = true }

        switch segment.selectedSegmentIndex {
        case 0:
            barChartView.isHidden = false
        case 1:
            dotChartView.isHidden = false
        case 2:
            circleChartView.isHidden = false
        case 3:
            lineChartView.isHidden = false
        case 4:
            semiCircleView.isHidden = false
        default:
            break
        }
    }
}
