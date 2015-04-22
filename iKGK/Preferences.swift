//
//  Preferences.swift
//  iKGK
//
//  Created by Matouš Hýbl on 20/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import Foundation

class Preferences {
    
    private static let TEACHER_MODE = "teacherMode"
    private static let ID = "id"
    
    private static let defaults = NSUserDefaults.standardUserDefaults()
    
    static var teacherMode: Bool {
        get {
            return defaults.boolForKey(TEACHER_MODE)
        }
        set {
            defaults.setBool(newValue, forKey: TEACHER_MODE)
            defaults.synchronize()
        }
    }
    
    static var id: Int {
        get {
            return defaults.integerForKey(ID)
        }
        set {
            defaults.setInteger(newValue, forKey: ID)
        }
    }
    
    private init() {
        
    }
}