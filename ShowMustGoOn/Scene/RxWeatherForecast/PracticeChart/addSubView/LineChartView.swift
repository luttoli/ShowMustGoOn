//
//  LineChartView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 3/15/25.
//

import UIKit

import SnapKit

class LineChartView: UIView {
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
private extension LineChartView {
    func setUp() {
        backgroundColor = .blue
    }
}

// MARK: - Method
extension LineChartView {

}
