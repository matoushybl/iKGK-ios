//
//  WebViewController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 18/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import UIWebViewAuthentication

class WebViewController: UIViewController, UIWebViewDelegate {
    
    var webView: UWAWebView!
    var activityIndicator: UIActivityIndicatorView!
    
    var url: String!
    
    override func loadView() {
        super.loadView()
        view = UIView()
        
        webView = CompositeView<UWAWebView>.addInto(view)
        activityIndicator = CompositeView<UIActivityIndicatorView>.addInto(view)
        activityIndicator.activityIndicatorViewStyle = .Gray
        
        webView.scalesPageToFit = true
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url!)!))
        addViewConstraints()
    }
    
    func addViewConstraints() {
        webView.snp_remakeConstraints { make in
            make.edges.equalTo(self.view)
        }
        activityIndicator.snp_remakeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        activityIndicator.startAnimating()
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        activityIndicator.stopAnimating()
        // FIXME show an errors
    }
}
