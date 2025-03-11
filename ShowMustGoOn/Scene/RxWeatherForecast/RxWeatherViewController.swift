//
//  RxWeatherViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/16/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxWeatherViewController: UIViewController {
    // MARK: - Properties
    
    
    // MARK: - Components
    lazy var chartButton: UIBarButtonItem = {
        let chartButton = UIBarButtonItem(image: UIImage(systemName: "chart.bar.xaxis"), style: .plain, target: self, action: #selector(goChartView))
        return chartButton
    }()
    
    //
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension RxWeatherViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension RxWeatherViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white
        
        let viewTitle = CustomLabel(title: "RxSwift WeatherApp", size: Constants.size.size20, weight: .Bold, color: .text.black)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewTitle)
        
        navigationItem.rightBarButtonItem = chartButton
        navigationController?.navigationBar.tintColor = .button.lavender
    }
}

// MARK: - SetUp
private extension RxWeatherViewController {
    func setUp() {
        
    }
}

// MARK: - Method
private extension RxWeatherViewController {
    //
    @objc func goChartView() {
        let chartVC = ChartViewController()
        chartVC.hidesBottomBarWhenPushed = true // VC tabbar 숨기기
        navigationController?.pushViewController(chartVC, animated: true)
    }
}
