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
    let segment = CustomSegment(items: ["반반", "선택", "키보드", "달력", "추가"])
    let basicCollectionView = BasicCollectionView()
    let selectCollectionView = SelectCollectionView()
    let keyboardCollectionView = KeyboardCollectionView()
    let calendarCollectionView = CalendarCollectionView()
    let addTodoCollectionView = AddTodoCollectionView()
    
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
        
        view.backgroundColor = .systemGray6
        
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
extension CollectionViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "CollectionView Practice", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension CollectionViewController {
    func setUp() {
        view.addSubview(segment)
        view.addSubview(basicCollectionView)
        view.addSubview(selectCollectionView)
        view.addSubview(keyboardCollectionView)
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
    }
}

// MARK: - Method
private extension CollectionViewController {
    func segmentClickEvent() {
        segment.selectedIndex
            .subscribe(onNext: { index in
                // 모든 뷰 숨김 처리
                let segmentView = [self.basicCollectionView, self.selectCollectionView, self.keyboardCollectionView, self.calendarCollectionView, self.addTodoCollectionView]
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
                    self.calendarCollectionView.isHidden = false
                case 4:
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
