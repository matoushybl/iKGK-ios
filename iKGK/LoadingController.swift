//
//  LoadingController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 19/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import AFNetworking
import Realm
import SwiftyJSON

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
            showError("Network not available")
        }
        activityIndicator.startAnimating()
        DataDownloader.loadData({
            let navigationController = UINavigationController(rootViewController: ChoosingController())
            navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            self.presentViewController(navigationController, animated: true, completion: nil)
            }, onError: {
            self.showError("Failed to load data, please try again later")
        })
    }
    
    // FIXME let's hope this shit works
    func isNetworkAvailable() -> Bool {
        return AFNetworkReachabilityManager.sharedManager().reachable
    }
    
    func showError(message: String) {
        UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Cancel").show()
    }
}
