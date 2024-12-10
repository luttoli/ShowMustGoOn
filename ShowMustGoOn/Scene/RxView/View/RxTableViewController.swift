//
//  RxTableViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/3/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxTableViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Components
    lazy var rxButtonPage: UIBarButtonItem = {
        let rxButtonPage = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(goRxButtonPage))
        return rxButtonPage
    }()
    
    let segment = CustomSegment(items: ["기본", "섹션", "혼합", "추가"])
    let rxBasicTableView = RxBasicTableView()
    let rxSectionTableView = RxSectionTableView()
    let rxMixTableView = RxMixTableView()
    let rxAddTableView = RxAddTableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension RxTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
        segmentClickEvent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segment.updateBottomLinePosition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segment.segment.selectedSegmentIndex = 0
        segment.updateBottomLinePosition()
        segmentClickEvent()
    }
}

// MARK: - Navigation
extension RxTableViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "RxSwift Practice", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
        
        navigationItem.rightBarButtonItem = rxButtonPage
        navigationController?.navigationBar.tintColor = .button.lavender
    }
}

// MARK: - SetUp
private extension RxTableViewController {
    func setUp() {
        view.addSubview(segment)
        view.addSubview(rxBasicTableView)
        view.addSubview(rxSectionTableView)
        view.addSubview(rxMixTableView)
        view.addSubview(rxAddTableView)
        
        segment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(Constants.size.size50)
        }
        
        rxBasicTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxSectionTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxMixTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        rxAddTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
    }
}

// MARK: - Method
private extension RxTableViewController {
    // 버튼 클릭 시 Rx버튼 페이지로 이동
    @objc func goRxButtonPage() {
        let rxButtonVC = RxButtonViewController()
        rxButtonVC.hidesBottomBarWhenPushed = true // VC tabbar 숨기기
        navigationController?.pushViewController(rxButtonVC, animated: true)
    }
    
    // 선택된 세그먼트에 반응
    func segmentClickEvent() {
        segment.selectedIndex
            .subscribe(onNext: { index in
                // 모든 뷰 숨김 처리 했다가
                let segmentView = [self.rxBasicTableView, self.rxSectionTableView, self.rxMixTableView, self.rxAddTableView, ]
                segmentView.forEach { $0.isHidden = true }
                
                // 선택된 세그먼트에 따라 해당 뷰만 보이게
                switch self.segment.segment.selectedSegmentIndex {
                case 0:
                    self.rxBasicTableView.isHidden = false
                case 1:
                    self.rxSectionTableView.isHidden = false
                case 2:
                    self.rxMixTableView.isHidden = false
                case 3:
                    self.rxAddTableView.isHidden = false
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
