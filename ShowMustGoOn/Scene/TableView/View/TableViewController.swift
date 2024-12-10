//
//  TableViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class TableViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    private let viewModel = FirstViewModel()
    
    // MARK: - Components
    let segment = CustomSegment(items: ["기본", "섹션", "혼합", "추가"])
    var basicTableView = BasicTableView()
    var sectionTableView = SectionTableView()
    var mixTableView = MixTableView()
    var addTableView = AddTableView()
    
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
        segmentClickEvent()
        mixTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segment.segment.selectedSegmentIndex = 0
        segment.updateBottomLinePosition()
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
        view.addSubview(segment)
        view.addSubview(basicTableView)
        view.addSubview(sectionTableView)
        view.addSubview(mixTableView)
        view.addSubview(addTableView)
        
        segment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        
        basicTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        sectionTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        mixTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        addTableView.snp.makeConstraints {
            $0.top.equalTo(segment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        addTableView.parentViewController = self
    }
}

// MARK: - Method
extension TableViewController: ThirdViewDelegate {
    // 선택된 세그먼트에 반응
    func segmentClickEvent() {
        segment.selectedIndex
            .subscribe(onNext: { index in
                // 모든 뷰 숨김 처리
                let segmentView = [self.basicTableView, self.sectionTableView, self.mixTableView, self.addTableView]
                segmentView.forEach { $0.isHidden = true }
                
                // 선택된 세그먼트에 따라 해당 뷰만 보이게
                switch index {
                case 0:
                    self.basicTableView.isHidden = false
                case 1:
                    self.sectionTableView.isHidden = false
                case 2:
                    self.mixTableView.isHidden = false
                case 3:
                    self.addTableView.isHidden = false
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    //
    func didSelectItem(with url: String) {
        guard let url = URL(string: url) else { return }

        let detailNewsViewController = DetailThirdViewController(url: url)
        detailNewsViewController.modalPresentationStyle = .formSheet
        present(detailNewsViewController, animated: true, completion: nil)
    }
}
