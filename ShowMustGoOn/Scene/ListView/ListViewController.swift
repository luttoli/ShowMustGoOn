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
    
    
    // MARK: - Components
    var listSegment: UISegmentedControl = {
        let listSegment = UISegmentedControl(items: ["테이블뷰", "콜랙션뷰", "메뉴뷰", "선택뷰"])
        listSegment.selectedSegmentIndex = 0
        
        let nomal: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.text.button.disabled,
            .font: UIFont.toPretendard(size: Constants.size.size10, weight: .SemiBold)
        ]
        
        let selected: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.text.button.black,
            .font: UIFont.toPretendard(size: Constants.size.size15, weight: .SemiBold)
        ]
        
        listSegment.setTitleTextAttributes(nomal, for: .normal)
        listSegment.setTitleTextAttributes(selected, for: .selected)
        
        let clearImage = UIImage()
        listSegment.setBackgroundImage(clearImage, for: .normal, barMetrics: .default) // 배경색 변경
        listSegment.setBackgroundImage(clearImage, for: .selected, barMetrics: .default) // 선택된 색 변경 -> 흰색
        listSegment.setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default) // 구분선 흰색
        
        return listSegment
    }()
    
    let firstView: UIView = {
        let firstView = UIView()
        firstView.backgroundColor = .red
        return firstView
    }()
    
    let secondView: UIView = {
        let secondView = UIView()
        secondView.backgroundColor = .blue
        return secondView
    }()
    
    let thirdView: UIView = {
        let thirdView = UIView()
        thirdView.backgroundColor = .green
        return thirdView
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
    
    override func viewWillAppear(_ animated: Bool) {
        listSegment.selectedSegmentIndex = 0
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
        
        listSegment.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.height.equalTo(Constants.size.size50)
        }

        view.addSubview(firstView)
        firstView.snp.makeConstraints {
            $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
        }
        
        listSegment.addAction(UIAction(handler: { [weak self] _ in
            self?.changeView()
        }), for: .valueChanged)
    }
}

// MARK: - Method
private extension ListViewController {
    func changeView() {
        if listSegment.selectedSegmentIndex == 0 {
            // 첫 번째 뷰를 보여줌
            secondView.removeFromSuperview() // 다른 뷰는 제거
            thirdView.removeFromSuperview()
            view.addSubview(firstView)
            firstView.snp.makeConstraints {
                $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
            }
        } else if listSegment.selectedSegmentIndex == 1 {
            // 두 번째 뷰를 보여줌
            firstView.removeFromSuperview() // 다른 뷰는 제거
            thirdView.removeFromSuperview()
            view.addSubview(secondView)
            secondView.snp.makeConstraints {
                $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
            }
        } else {
            firstView.removeFromSuperview()
            thirdView.removeFromSuperview()
            view.addSubview(thirdView)
            thirdView.snp.makeConstraints {
                $0.top.equalTo(listSegment.snp.bottom).offset(Constants.margin.vertical)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margin.horizontal)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.horizontal)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.margin.vertical)
            }
        }
    }
}

// MARK: - Delegate
extension ListViewController {
    
}
