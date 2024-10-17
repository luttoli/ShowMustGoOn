//
//  UIFont.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

enum fontWeight {
    case light
    case medium
    case Bold
    case ExtraBold
    case SemiBold
    case Regular
}

extension UIFont {
    static func toPretendard(size: CGFloat, weight: fontWeight) -> UIFont {
        return UIFont(name: "PretendardVariable-\(weight)", size: size)!
    }
}
