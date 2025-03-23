//
//  RxCollectionViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/16/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxCollectionViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
//    lazy var calendarButton: UIBarButtonItem = {
//        let calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(goCalendarView))
//        return calendarButton
//    }()
    
    let segment = CustomSegment(items: ["반반", "선택", "키보드", "계산기", "달력", "추가"])
    let rxBasicCollectionView = RxBasicCollectionView()
    let rxSelectCollectionView = RxSelectCollectionView()
    let rxKeyboardCollectionView = RxKeyboardCollectionView()
    let rxCalculateCollectionView = RxCalculateCollectionView()
    let rxCalendarCollectionView = RxCalendarCollectionView()
    let rxBackMiracleCollectionView = RxBackMiracleCollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension RxCollectionViewController {
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
extension RxCollectionViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "RxSwift CollectionView", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension RxCollectionViewController {
    func setUp() {
        view.addSubview(segment)
        view.addSubview(rxBasicCollectionView)
        view.addSubview(rxSelectCollectionView)
        view.addSubview(rxKeyboardCollectionView)
        view.addSubview(rxCalculateCollectionView)
        view.addSubview(rxCalendarCollectionView)
        view.addSubview(rxBackMiracleCollectionView)
        
        segment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        
        rxBasicCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxSelectCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxKeyboardCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxCalculateCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxCalendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxBackMiracleCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
//        backMiracleCollectionView.parentViewController = self
    }
}

// MARK: - Method
private extension RxCollectionViewController {
    //
//    @objc func goCalendarView() {
//        let calendarVC = CalendarViewController()
//        calendarVC.hidesBottomBarWhenPushed = true // VC tabbar 숨기기
//        navigationController?.pushViewController(calendarVC, animated: true)
//    }
    
    func segmentClickEvent() {
        segment.selectedIndex
            .subscribe(onNext: { index in
                // 모든 뷰 숨김 처리
                let segmentView = [self.rxBasicCollectionView, self.rxSelectCollectionView, self.rxKeyboardCollectionView, self.rxCalculateCollectionView, self.rxCalendarCollectionView, self.rxBackMiracleCollectionView]
                segmentView.forEach { $0.isHidden = true }
                
                // 선택된 세그먼트에 따라 해당 뷰만 보이게
                switch index {
                case 0:
                    self.rxBasicCollectionView.isHidden = false
                case 1:
                    self.rxSelectCollectionView.isHidden = false
                case 2:
                    self.rxKeyboardCollectionView.isHidden = false
                case 3:
                    self.rxCalculateCollectionView.isHidden = false
                case 4:
                    self.rxCalendarCollectionView.isHidden = false
                case 5:
                    self.rxBackMiracleCollectionView.isHidden = false
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension RxCollectionViewController {
    
}
