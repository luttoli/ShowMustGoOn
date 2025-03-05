//
//  CollectionViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/31/24.
//

import UIKit

import SnapKit

class CollectionViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    lazy var calendarButton: UIBarButtonItem = {
        let calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(goCalendarButton))
        return calendarButton
    }()
    
    let segment = CustomSegment(items: ["반반", "선택", "키보드", "계산기", "달력", "추가"])
    let basicCollectionView = BasicCollectionView()
    let selectCollectionView = SelectCollectionView()
    let keyboardCollectionView = KeyboardCollectionView()
    let calculateCollectionView = CalculateCollectionView()
    let calendarCollectionView = CalendarCollectionView()
    let addTodoCollectionView = BackMiracleCollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension CollectionViewController {
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
        segment.segment.selectedSegmentIndex = 5
        segment.updateBottomLinePosition()
        
        // 초기화된 세그먼트 인덱스에 맞는 화면 업데이트
        segment.selectedIndex.accept(5)
    }
}

// MARK: - Navigation
extension CollectionViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "UICollectionView", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
        
        navigationItem.rightBarButtonItem = calendarButton
        navigationController?.navigationBar.tintColor = .button.lavender
    }
}

// MARK: - SetUp
private extension CollectionViewController {
    func setUp() {
        view.addSubview(segment)
        view.addSubview(basicCollectionView)
        view.addSubview(selectCollectionView)
        view.addSubview(keyboardCollectionView)
        view.addSubview(calculateCollectionView)
        view.addSubview(calendarCollectionView)
        view.addSubview(addTodoCollectionView)
        
        segment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        
        basicCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        selectCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        keyboardCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        calculateCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        calendarCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        addTodoCollectionView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        addTodoCollectionView.parentViewController = self
    }
}

// MARK: - Method
private extension CollectionViewController {
    //
    @objc func goCalendarButton() {
        let calendarVC = CalendarViewController()
        calendarVC.hidesBottomBarWhenPushed = true // VC tabbar 숨기기
        navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    func segmentClickEvent() {
        segment.selectedIndex
            .subscribe(onNext: { index in
                // 모든 뷰 숨김 처리
                let segmentView = [self.basicCollectionView, self.selectCollectionView, self.keyboardCollectionView, self.calculateCollectionView, self.calendarCollectionView, self.addTodoCollectionView]
                segmentView.forEach { $0.isHidden = true }
                
                // 선택된 세그먼트에 따라 해당 뷰만 보이게
                switch index {
                case 0:
                    self.basicCollectionView.isHidden = false
                case 1:
                    self.selectCollectionView.isHidden = false
                case 2:
                    self.keyboardCollectionView.isHidden = false
                case 3:
                    self.calculateCollectionView.isHidden = false
                case 4:
                    self.calendarCollectionView.isHidden = false
                case 5:
                    self.addTodoCollectionView.isHidden = false
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Delegate
extension CollectionViewController {
    
}
