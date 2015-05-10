//
//  TimeTableController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 07/05/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit

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
            choosingController.onClassSelected = { classModel in
                self.loadUrl(UrlProvider.getTimetableUrlForId(classModel.id, teacher: false))
            }
            choosingController.onTeacherSelected = { teacher in
                self.loadUrl(UrlProvider.getTimetableUrlForId(teacher.id, teacher: true))
            }
            self.navigationController?.pushViewController(choosingController, animated: true)
        }))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
