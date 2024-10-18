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
        transitionToList()
    }
}

// MARK: - SetUp
private extension SplashViewController {
    func setUp() {
        view.addSubview(loadingGif)
        
        loadingGif.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        do {
            let gif = try UIImage(gifName: "codingGif.gif")
            loadingGif.setGifImage(gif, loopCount: 3)
        } catch {
            print("fail")
        }
    }
}

// MARK: - Method
private extension SplashViewController {
    // 화면 전환
    func transitionToList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { // 후 전환 (GIF를 보여주기 위해)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let customTBC = CustomTabBarController()
                window.rootViewController = customTBC
                window.makeKeyAndVisible()
            }
        }
    }
}
