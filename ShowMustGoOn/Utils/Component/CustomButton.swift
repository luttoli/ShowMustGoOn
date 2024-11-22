//
//  CustomButton.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/22/24.
//

import UIKit

import SnapKit

class CustomButton: UIButton {
    // MARK: enum
    enum ButtonType {
        case textButton(String)
        case plus
        case minus
        case checkBox
        
        var image: UIImage? {
            switch self {
            case .textButton:
                return nil
            case .plus:
                return UIImage(systemName: "plus")
            case .minus:
                return UIImage(systemName: "minus")
            case .checkBox:
                return UIImage(named: "icon_checkBox.svg")
            }
        }
    }
    
    // MARK: Initializer
    init(buttonType: ButtonType, size: CGFloat, tintColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: .zero)
        setUp(type: buttonType, size: size, tintColor: tintColor, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setUp
private extension CustomButton {
    func setUp(type: ButtonType, size: CGFloat, tintColor: UIColor, backgroundColor: UIColor) {
        setImage(type.image, for: .normal)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        
        if case let .textButton(text) = type {
            setTitle(text, for: .normal)
            setTitleColor(.text.white, for: .normal)
            titleLabel?.font = UIFont.toPretendard(size: Constants.size.size15, weight: .medium)
        }
        
        self.snp.makeConstraints {
            $0.width.height.equalTo(size)
        }

        clipsToBounds = true
        contentHorizontalAlignment = .center
    }
}
