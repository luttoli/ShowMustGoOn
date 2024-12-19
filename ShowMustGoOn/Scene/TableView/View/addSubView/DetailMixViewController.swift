//
//  DetailMixViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/8/24.
//

import UIKit

import SnapKit
import WebKit

class DetailMixViewController: UIViewController, WKNavigationDelegate {
    // MARK: - Properties
    var url: URL?
    var newsTitle: String?
    
    // MARK: - Components
    private var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = true
        return webView
    }()
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension DetailMixViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        setUp()
    }
}

// MARK: - SetUp
private extension DetailMixViewController {
    func setUp() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        webView.navigationDelegate = self
    }
}
