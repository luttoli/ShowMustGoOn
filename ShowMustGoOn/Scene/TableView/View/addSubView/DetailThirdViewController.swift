//
//  DetailThirdViewController.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/8/24.
//

import UIKit

import SnapKit
import WebKit

class DetailThirdViewController: UIViewController, WKNavigationDelegate {
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
    
    init(url: URL?, title: String?) {
        self.url = url
        self.newsTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LifeCycle
extension DetailThirdViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        navigationUI()
        setUp()
    }
}

// MARK: - Navigation
extension DetailThirdViewController {
    func navigationUI() {
        navigationController?.navigationBar.barTintColor = .background.white

        let titleLabel = CustomLabel(title: self.newsTitle ?? "", size: Constants.size.size15, weight: .SemiBold, color: .text.black)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .text.black
    }
}

// MARK: - SetUp
private extension DetailThirdViewController {
    func setUp() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        webView.navigationDelegate = self
    }
}
