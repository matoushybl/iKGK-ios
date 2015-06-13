//
//  WebViewController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 18/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import WebKit
import SwiftKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var activityIndicator: UIActivityIndicatorView!
    
    var url: String!
    
    override func loadView() {
        super.loadView()
        view = UIView()
        
        webView => view
        webView.navigationDelegate = self
        
        activityIndicator => view
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
    
    private func addViewConstraints() {
        webView.snp_remakeConstraints { make in
            make.edges.equalTo(view)
        }
        activityIndicator.snp_remakeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    internal func loadUrl(url: String) {
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
        let host: String = webView.URL!.host!
        let authMethod = challenge.protectionSpace.authenticationMethod
        if(authMethod == NSURLAuthenticationMethodDefault || authMethod == NSURLAuthenticationMethodHTTPBasic || authMethod == NSURLAuthenticationMethodHTTPDigest) {
            let alertController = UIAlertController(title: "Authentification requiered", message: "Please input your credentials", preferredStyle: .Alert)
            alertController.addTextFieldWithConfigurationHandler { textField in
                textField.placeholder = "Username"
            }
            alertController.addTextFieldWithConfigurationHandler { textField in
                textField.placeholder = "Password"
                textField.secureTextEntry = true
            }
            alertController.addAction(UIAlertAction(title: "OK", style: .Default) { handler in
                let credential = NSURLCredential(user: (alertController.textFields?[0] as! UITextField).text, password: (alertController.textFields?[1] as! UITextField).text, persistence: .Permanent)
                completionHandler(.UseCredential, credential)
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { handler in
                completionHandler(.CancelAuthenticationChallenge, nil)
            })
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            completionHandler(.CancelAuthenticationChallenge, nil)
        }
    }
}
