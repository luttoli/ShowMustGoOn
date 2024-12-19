//
//  WebView.swift
//  ShowMustGoOn
//
//  Created by 김지훈 on 11/8/24.
//

import UIKit

func webView(from viewController: UIViewController, urlString: String, newsTitle: String) {
    guard let url = URL(string: urlString) else {
        return
    }
    
    let detailMixVC = DetailMixViewController(url: url)
    viewController.navigationController?.pushViewController(detailMixVC, animated: true)
}
