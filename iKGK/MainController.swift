//
//  MainController.swift
//  iKGK
//
//  Created by Matouš Hýbl on 17/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import UIKit

@objc(MainController)
class MainController: UIViewController {
    
    var marksButton: MainButton!
    var substitutionButton: MainButton!
    var timetableButton: MainButton!
    var moodleButton: MainButton!
    var canteenButton: MainButton!
    var websiteButton: MainButton!
    
    
    override func loadView() {
        super.loadView()
        view = UIView()
        
        marksButton = CompositeView<MainButton>.addInto(view)
        substitutionButton = CompositeView<MainButton>.addInto(view)
        timetableButton = CompositeView<MainButton>.addInto(view)
        moodleButton = CompositeView<MainButton>.addInto(view)
        canteenButton = CompositeView<MainButton>.addInto(view)
        websiteButton = CompositeView<MainButton>.addInto(view)
        
        navigationItem.title = "iKGK"
        navigationItem.hidesBackButton = true
        setupViews()
        DataDownloader.loadData(nil, onError: nil)
    }
    
    func setupViews() {
        marksButton.title = "Marks"
        marksButton.onClick = {
            self.openController(WebViewController(), url: UrlProvider.MARKS, title: "Marks")
        }
        substitutionButton.title = "Substitution"
        substitutionButton.onClick = {
            self.openController(SubstitutionController(), url: UrlProvider.getSubstitutionUrl(), title: "Substitution")
        }
        timetableButton.title = "Timetable"
        timetableButton.onClick = {
            self.openController(TimetableController(), url: UrlProvider.getTimetableUrl(), title: "Timetable")
        }
        moodleButton.title = "Moodle"
        moodleButton.onClick = {
            self.openController(WebViewController(), url: UrlProvider.MOODLE, title: "Moodle")
        }
        canteenButton.title = "Canteen"
        canteenButton.onClick = {
            // FIXME not a good way
            //UIApplication.sharedApplication().openURL(NSURL(string: UrlProvider.CANTEEN)!)
            self.openController(WebViewController(), url: UrlProvider.CANTEEN, title: "Canteen")
        }
        websiteButton.title = "Website"
        websiteButton.onClick = {
            self.openController(WebViewController(), url: UrlProvider.WEBSITE, title: "Website")
        }
        addConstraints()
    }
    
    func addConstraints() {
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
    
    func openController(controller: WebViewController, url: String, title: String) {
        controller.navigationItem.title = title
        controller.url = url
        navigationController?.pushViewController(controller, animated: true)
    }

}
