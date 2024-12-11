//
//  RxBasicTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxBasicTableView: UIView {
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
private extension RxBasicTableView {
    func setUp() {
        backgroundColor = .yellow
    }
}

// MARK: - Method
extension RxBasicTableView {

}

// MARK: - delegate
extension RxBasicTableView {
    
}