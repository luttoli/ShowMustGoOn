//
//  BlockCollectionViewCell.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 2/25/25.
//

import UIKit

import SnapKit

class BlockCollectionViewCell: UICollectionViewCell {
    // MARK: - Components
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

// MARK: - SetUp
private extension BlockCollectionViewCell {
    func setUp() {
        
    }
}

// MARK: - Method
extension BlockCollectionViewCell {

}
