//
//  MainController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 17/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit
import SwiftKit

@objc(MainController)
class MainController: UIViewController {
    
    private var marksButton: MainButton!
    private var substitutionButton: MainButton!
    private var timetableButton: MainButton!
    private var moodleButton: MainButton!
    private var canteenButton: MainButton!
    private var websiteButton: MainButton!
    
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        
        marksButton => view
        marksButton.title = "Marks"
        marksButton.onClick += { [unowned self] _ in
            self.openController(WebViewController(), url: UrlProvider.MARKS, title: "Marks")
        }
        
        substitutionButton => view
        substitutionButton.title = "Substitution"
        substitutionButton.onClick += { [unowned self] _ in
            self.openController(SubstitutionController(), url: UrlProvider.getSubstitutionUrl(), title: "Substitution")
        }
        
        timetableButton => view
        timetableButton.title = "Timetable"
        timetableButton.onClick += { [unowned self] _ in
            self.openController(TimetableController(), url: UrlProvider.getTimetableUrl(), title: "Timetable")
        }
        
        moodleButton => view
        moodleButton.title = "Moodle"
        moodleButton.onClick += { [unowned self] _ in
            self.openController(WebViewController(), url: UrlProvider.MOODLE, title: "Moodle")
        }
        
        canteenButton => view
        canteenButton.title = "Canteen"
        canteenButton.onClick += { [unowned self] _ in
            // FIXME not a good way
            //UIApplication.sharedApplication().openURL(NSURL(string: UrlProvider.CANTEEN)!)
            self.openController(WebViewController(), url: UrlProvider.CANTEEN, title: "Canteen")
        }
        
        websiteButton => view
        websiteButton.title = "Website"
        websiteButton.onClick += { [unowned self] _ in
            self.openController(WebViewController(), url: UrlProvider.WEBSITE, title: "Website")
        }
        
        addConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataDownloader.loadData(nil, onError: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "iKGK"
        navigationItem.hidesBackButton = true
    }
    
    private func addConstraints() {
        marksButton.snp_remakeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(40)
        }
        substitutionButton.snp_remakeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.marksButton.snp_bottom)
            make.height.equalTo(40)
        }
        timetableButton.snp_remakeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.substitutionButton.snp_bottom)
            make.height.equalTo(40)
        }
        moodleButton.snp_remakeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.timetableButton.snp_bottom)
            make.height.equalTo(40)
        }
        canteenButton.snp_remakeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.moodleButton.snp_bottom)
            make.height.equalTo(40)
        }
        websiteButton.snp_remakeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.canteenButton.snp_bottom)
            make.height.equalTo(40)
        }
    }
    
    private func openController(controller: WebViewController, url: String, title: String) {
        controller.navigationItem.title = title
        controller.url = url
        navigationController?.pushViewController(controller, animated: true)
    }

}
