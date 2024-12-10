//
//  RxMixTableView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 12/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class RxMixTableView: UIView {
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
private extension RxMixTableView {
    func setUp() {
        backgroundColor = .blue
    }
}

// MARK: - Method
extension RxMixTableView {

}

// MARK: - delegate
extension RxMixTableView {
    
}
