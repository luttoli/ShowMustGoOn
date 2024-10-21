//
//  Constants.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/17/24.
//

import UIKit

struct Constants {
    static let margin = Margin()
    static let spacing = Spacing()
    static let radius = Radius()
    static let size = Size()
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

struct Margin {
    let vertical: CGFloat = 12
    let horizontal: CGFloat = 16
    let cellSpacing: CGFloat = 20
}

struct Spacing {
    let px4: CGFloat = 4
    let px8: CGFloat = 8
    let px10: CGFloat = 10
    let px12: CGFloat = 12
    let px14: CGFloat = 14
    let px20: CGFloat = 20
}

struct Radius {
    let px4: CGFloat = 4
    let px6: CGFloat = 6
    let px8: CGFloat = 8
    let px10: CGFloat = 10
    let px12: CGFloat = 12
    let px14: CGFloat = 14
    let px16: CGFloat = 16
    let px20: CGFloat = 20
}

struct Size {
    let size10: CGFloat = 10
    let size20: CGFloat = 20
    let size30: CGFloat = 30
    let size40: CGFloat = 40
    let size50: CGFloat = 50
    let size60: CGFloat = 60
    let size70: CGFloat = 70
    let size80: CGFloat = 80
    let size90: CGFloat = 90
    let size100: CGFloat = 100
    let size120: CGFloat = 120
    let size130: CGFloat = 130
    let size300: CGFloat = 300
}
