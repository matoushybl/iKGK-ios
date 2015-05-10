//
//  WebViewController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 18/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController  {
    
    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView!
    
    var url: String!
    
    override func loadView() {
        super.loadView()
        view = UIView()
        
        webView = CompositeView<WKWebView>.addInto(view)
        activityIndicator = CompositeView<UIActivityIndicatorView>.addInto(view)
        activityIndicator.activityIndicatorViewStyle = .Gray
        activityIndicator.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        loadUrl(url)
        addViewConstraints()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(showsSettings()) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "action_settings"), style: .Plain, target: self, action: "openSettings")
        }
    }
    
    func showsSettings() -> Bool {
        return false
    }
    
    func openSettings() {
        // To be overriden
    }
    
    func addViewConstraints() {
        webView.snp_remakeConstraints { make in
            make.edges.equalTo(view)
        }
        activityIndicator.snp_remakeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func loadUrl(url: String) {
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
}
