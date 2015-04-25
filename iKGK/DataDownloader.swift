//
//  DataDownloader.swift
//  iKGK
//
//  Created by Matouš Hýbl on 25/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import Foundation
import AFNetworking
import Realm
import SwiftyJSON

class DataDownloader {
    
    static let CLASSES_URL = "http://matoushybl.github.io/KGK-biology/classes.json"
    static let TEACHERS_URL = "http://matoushybl.github.io/KGK-biology/teachers.json"
    
    static let realm = RLMRealm.defaultRealm()
    static let networkManager = AFHTTPRequestOperationManager()
    
    class func loadAndSaveTeachers(onSuccess: (() -> ())?, onError: (() -> ())?) {
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
            onSuccess?()
            
            }, failure: { operation, error in
                onError?()
        })
    }
    
    class func loadAndSaveClasses(onSuccess: (() -> ())?, onError: (() -> ())?) {
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
            self.loadAndSaveTeachers(onSuccess, onError: onError)
            
            }, failure: { operation, error in
                onError?()
        })
    }
    
    class func loadData(onSuccess: (() -> ())?, onError: (() -> ())?) {
        loadAndSaveClasses(onSuccess, onError: onError)
    }
}