//
//  SplashViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 10/18/24.
//

import UIKit

import Combine
import SnapKit
import SwiftyGif

class SplashViewController: UIViewController {
    // MARK: - Components
    var loadingGif = UIImageView()
    
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
        view.addSubview(loadingGif)
        
        loadingGif.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        // Gif 세팅
        do {
            let gif = try UIImage(gifName: "codingGif.gif")
            loadingGif.setGifImage(gif, loopCount: 2)
            loadingGif.delegate = self  // Delegate 설정
        } catch {
            print("fail")
        }
    }
}

// MARK: - SwiftyGifDelegate
extension SplashViewController: SwiftyGifDelegate {
    // GIF의 루프가 끝났을 때 호출되는 메서드
    func gifDidStop(sender: UIImageView) {
        transitionToList()
    }
}

// MARK: - Method
private extension SplashViewController {
    // 화면 전환
    func transitionToList() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let customTBC = CustomTabBarController()
            window.rootViewController = customTBC
            window.makeKeyAndVisible()
        }
    }
}
