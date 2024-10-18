//
//  SplashViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/18/24.
//

import UIKit

import Combine
import FLAnimatedImage
import SnapKit

class SplashViewController: UIViewController {
    // MARK: - Components
    var loadingGIF = FLAnimatedImageView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension SplashViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background.white
        
        setUp()
    }
}

// MARK: - SetUp
private extension SplashViewController {
    func setUp() {
        view.addSubview(loadingGIF)
        
        loadingGIF.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        // GIF 파일 불러오기
        if let gifURL = Bundle.main.url(forResource: "codingGIF", withExtension: "gif"),
           let gifData = try? Data(contentsOf: gifURL) {
            let animatedImage = FLAnimatedImage(gifData: gifData)
            loadingGIF.animatedImage = animatedImage
        }
    }
}

// MARK: - Method
private extension SplashViewController {
    
}
