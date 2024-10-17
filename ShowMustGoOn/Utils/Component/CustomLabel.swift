//
//  CustomLabel.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

class CustomLabel: UILabel {
    init(title: String, size: CGFloat, weight: fontWeight, color: UIColor? = nil) {
        super.init(frame: .zero)
        
        self.text = title
        self.font = .toPretendard(size: size, weight: weight)
        if let color = color {
            textColor = color
        } else {
            textColor = .text.black
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
