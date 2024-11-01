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
    private let viewModel = TableViewModel()
    
    // MARK: - Components
    var tableSegmentView = TableSegmentView()
    var firstView = FirstBasicView()
    
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
        didTapSegment()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableSegmentView.updateBottomLinePosition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableSegmentView.tableSegment.selectedSegmentIndex = 0
        tableSegmentView.updateBottomLinePosition()
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
        view.addSubview(tableSegmentView)
        view.addSubview(firstView)
        
        tableSegmentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        
        firstView.snp.makeConstraints {
            $0.top.equalTo(tableSegmentView.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        changeView()
    }
}

// MARK: - Method
private extension TableViewController {
    // 세그먼트 클릭 이벤트
    func didTapSegment() {
        tableSegmentView.tableSegment.addAction(UIAction(handler: { [weak self] _ in // combine 연습하기
            guard let self = self else { return }
            self.tableSegmentView.animateSelectedSegment()
            self.tableSegmentView.updateBottomLinePosition()
            self.changeView()
        }), for: .valueChanged)
    }
    
    // 세그먼트 선택 시 View 노출
    func changeView() {
        // 모든 뷰 숨김 처리 했다가
        let segmentView = [firstView, ]
        segmentView.forEach { $0.isHidden = true }
        
        // 선택된 세그먼트에 따라 해당 뷰만 보이게
        switch tableSegmentView.tableSegment.selectedSegmentIndex {
        case 0:
            firstView.isHidden = false
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
}