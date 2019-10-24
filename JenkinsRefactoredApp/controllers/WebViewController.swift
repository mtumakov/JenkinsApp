//
//  WebViewController.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 18/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private let webView = WKWebView()
    let build: Build
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let url = URL(string: "\(build.url)/allure")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    init(build: Build) {
        self.build = build
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
