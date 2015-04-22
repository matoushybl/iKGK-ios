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
    
    let CLASSES_URL = "http://matoushybl.github.io/KGK-biology/classes.json"
    let TEACHERS_URL = "http://matoushybl.github.io/KGK-biology/teachers.json"
    
    let realm = RLMRealm.defaultRealm()
    let networkManager = AFHTTPRequestOperationManager()
    
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
        loadClasses()
    }
    
    // FIXME let's hope this shit works
    func isNetworkAvailable() -> Bool {
        return AFNetworkReachabilityManager.sharedManager().reachable
    }
    
    // FIXME move these methods to separate class so that they are usable everywhere
    func loadClasses() {
        networkManager.GET(CLASSES_URL, parameters: nil, success: { operation, object in
            let json = JSON(object)
            var data = [ClassModel]()
            let classes = json["classes"]
            for(_, aClass) in classes {
                let classModel = ClassModel()
                classModel.id = aClass["id"].intValue
                classModel.name = aClass["name"].stringValue
                
                data.append(classModel)
            }
            self.realm.transactionWithBlock() {
                self.realm.deleteObjects(ClassModel.allObjects())
                self.realm.addObjects(data)
            }
            self.loadTeachers()
            
        }) { operation, error in
            self.showError("Failed to load data, please try again later")
        }
    }
    
    func loadTeachers() {
        networkManager.GET(TEACHERS_URL, parameters: nil, success: { operation, object in
        let json = JSON(object)
        var data = [TeacherModel]()
        let classes = json["teachers"]
        for(_, aClass) in classes {
            let teacherModel = TeacherModel()
            teacherModel.id = aClass["id"].intValue
            teacherModel.name = aClass["name"].stringValue
            
            data.append(teacherModel)
        }
        self.realm.transactionWithBlock() {
            self.realm.deleteObjects(TeacherModel.allObjects())
            self.realm.addObjects(data)
        }
            // use navigation controller since here
            self.navigationController?.pushViewController(ChoosingController(), animated: true)
        
        }) { operation, error in
            self.showError("Failed to load data, please try again later")
        }
    }
    
    func showError(message: String) {
        UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Cancel").show()
    }
}
