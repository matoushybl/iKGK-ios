//
//  LoadingController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 19/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import AFNetworking

@objc(LoadingController)
class LoadingController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    var label: UILabel!
    
    override func loadView() {
        super.loadView()
        view = UIView()
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        
        activityIndicator = CompositeView<UIActivityIndicatorView>.addInto(view)
        label = CompositeView<UILabel>.addInto(view)
        label.text = "Loading classes and teachers"
        label.textColor = UIColor.whiteColor()
        
        activityIndicator.snp_remakeConstraints { make in
            make.leading.trailing.centerY.equalTo(self.view)
        }
        label.snp_remakeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.activityIndicator.snp_bottom).offset(10)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(!isNetworkAvailable()) {
            UIAlertView(title: "Error", message: "Internet connection not available", delegate: nil, cancelButtonTitle: "Cancel").show()
        }
        activityIndicator.startAnimating()
        // FIXME load classes etc.
    }
    
    // FIXME let's hope this shit works
    func isNetworkAvailable() -> Bool {
        return AFNetworkReachabilityManager.sharedManager().reachable
    }
}
