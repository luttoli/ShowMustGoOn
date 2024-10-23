//
//  ListViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

import Combine
import SnapKit

class ListViewController: UIViewController {
    // MARK: - Properties
    var tableViewCellItem = Array(1...50).map {"\($0)"}
    
    // MARK: - Components
    var listSegment: UISegmentedControl = {
        let listSegment = UISegmentedControl(items: ["테이블뷰", "콜랙션뷰", "카테고리", "선택하기"])
        listSegment.selectedSegmentIndex = 0
        
        // 선택, 미선택 타이틀설정
        listSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.toPretendard(size: Constants.size.size15, weight: .Regular), .foregroundColor: UIColor.text.subDarkGray], for: .normal)
        listSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.toPretendard(size: Constants.size.size15, weight: .SemiBold), .foregroundColor: UIColor.text.black], for: .selected)
        
        // 배경색 설정
        listSegment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default) // 배경색 변경
        listSegment.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default) // 선택된 색 변경 -> 흰색
        
        // 구분선 설정
        listSegment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default) // 구분선 흰색
        return listSegment
    }()
    
    // 선택한 세그먼트 바텀라인
    var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .button.lavender
        return view
    }()
    
    // 테이블뷰
    var firstTableView: UITableView = {
        let firstTableView = UITableView(frame: .zero, style: .plain)
        firstTableView.register(NumTableViewCell.self, forCellReuseIdentifier: NumTableViewCell.identifier)
        firstTableView.backgroundColor = .clear
        firstTableView.tableFooterView = UIView(frame: .zero)
        firstTableView.sectionFooterHeight = 0
        firstTableView.showsVerticalScrollIndicator = true
        firstTableView.separatorStyle = .singleLine
        return firstTableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension ListViewController {
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
        listSegment.selectedSegmentIndex = 0
        updateBottomLinePosition()
        changeView()
    }
}

// MARK: - Navigation
extension ListViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "List Practice", size: Constants.size.size30, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
    }
}

// MARK: - SetUp
private extension ListViewController {
    func setUp() {
        view.addSubview(listSegment)
        view.addSubview(bottomLineView)
        view.addSubview(firstTableView)
        
        listSegment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }
        listSegment.addAction(UIAction(handler: { [weak self] _ in // combine 연습하기
            guard let self = self else { return }
            self.animateSelectedSegment(segment: self.listSegment)
            self.updateBottomLinePosition()
            self.changeView()
        }), for: .valueChanged)
        
        firstTableView.snp.makeConstraints {
            $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        changeView()
    }
}

// MARK: - Method
private extension ListViewController {
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
        let selectedSegmentIndex = listSegment.selectedSegmentIndex
        let segmentWidth = listSegment.bounds.width / CGFloat(listSegment.numberOfSegments)
        let lineHeight: CGFloat = 3 // 바텀 라인의 높이

        UIView.animate(withDuration: 0.3) {
            self.bottomLineView.frame = CGRect(
                x: CGFloat(selectedSegmentIndex) * segmentWidth + Constants.margin.horizontal,
                y: self.listSegment.frame.maxY - lineHeight,
                width: segmentWidth,
                height: lineHeight
            )
        }
    }
    
    // 세그먼트 선택 시 View 노출
    func changeView() {
        // 모든 뷰 숨김 처리 했다가
        let segmentView = [firstTableView, ]
        segmentView.forEach { $0.isHidden = true }
        
        // 선택된 세그먼트에 따라 해당 뷰만 보이게
        switch listSegment.selectedSegmentIndex {
        case 0:
            firstTableView.isHidden = false
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

// MARK: - Delegate
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCellItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NumTableViewCell.identifier, for: indexPath) as? NumTableViewCell else { return UITableViewCell() }
        
        cell.numLabel.text = tableViewCellItem[indexPath.row].description
        
        return cell
    }
}
