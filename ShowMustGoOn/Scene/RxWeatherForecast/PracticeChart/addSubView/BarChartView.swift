//
//  BarChartView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/12/25.
//

import UIKit

import SnapKit

class BarChartView: UIView {
    // MARK: - Properties
    
    
    // MARK: - Components
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
private extension BarChartView {
    func setUp() {
        backgroundColor = .white
    }
}

// MARK: - Method
extension BarChartView {

}
