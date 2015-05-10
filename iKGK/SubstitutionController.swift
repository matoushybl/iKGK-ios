//
//  SubstitutionController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 07/05/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit

class SubstitutionController: WebViewController {
    
    override func openSettings() {
        let alertController = UIAlertController(title: "Substitution", message: "", preferredStyle: .ActionSheet)
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        if(!UrlProvider.shouldDisplayNextSubstitution()) {
            let action = UIAlertAction(title: "Next day", style: UIAlertActionStyle.Default, handler: { action in
                self.loadUrl(UrlProvider.getNextDaySubstitutionUrl())
            })
            alertController.addAction(action)
        }
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func showsSettings() -> Bool {
        return true
    }
}
