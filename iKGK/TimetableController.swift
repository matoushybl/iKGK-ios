//
//  TimeTableController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 07/05/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import SwiftKit

class TimetableController: WebViewController {
    
    override func showsSettings() -> Bool {
        return true
    }
    
    override func openSettings() {
        let alertController = UIAlertController(title: "Timetable", message: "", preferredStyle: .ActionSheet)
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        alertController.addAction(UIAlertAction(title: "My class", style: .Default, handler: { handler in
            self.loadUrl(UrlProvider.getTimetableUrl())
        }))
        alertController.addAction(UIAlertAction(title: "Other timetable", style: .Default, handler: { handler in
            let choosingController = ChoosingController()
            choosingController.onClassSelected += { [unowned self] data in
                self.loadUrl(UrlProvider.getTimetableUrlForId(data.input.id, teacher: false))
            }
            choosingController.onTeacherSelected += { [unowned self] data in
                self.loadUrl(UrlProvider.getTimetableUrlForId(data.input.id, teacher: true))
            }
            self.navigationController?.pushViewController(choosingController, animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
