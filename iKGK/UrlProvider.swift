//
//  UrlProvider.swift
//  iKGK
//
//  Created by Matouš Hýbl on 19/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import Foundation
import SwiftMoment

class UrlProvider {
    
    static let MARKS = "http://www.gymkyjov.cz/isas/prubezna-klasifikace.php"
    static let MOODLE = "http://www.gymkyjov.cz/moodle"
    static let CANTEEN = "http://www.gymkyjov.cz:8082"
    static let WEBSITE = "http://www.gymkyjov.cz/"
    
    static let TIMETABLE = "http://www.gymkyjov.cz/isas/rozvrh-hodin.php?zobraz=tridy-1&rozvrh=%d"
    static let TEACHER_TIMETABLE = "http://www.gymkyjov.cz/isas/rozvrh-hodin.php?zobraz=ucitel&rozvrh=%d"
    
    static let SUBSTITUTION_TOMORROW_URL = "http://www.gymkyjov.cz/isas/suplovani.php?zobraz=tridy-1&suplovani=%d&rezim=den&datum=%@"
    static let SUBSTITUTION_URL = "http://www.gymkyjov.cz/isas/suplovani.php?zobraz=tridy-1&suplovani=%d"
    
    static let TEACHER_SUBSTITUTION_URL = "http://www.gymkyjov.cz/isas/suplovani.php?zobraz=suplujici&suplovani=%d"
    static let TEACHER_SUBSTITUTION_TOMORROW_URL = "http://www.gymkyjov.cz/isas/suplovani.php?zobraz=suplujici&suplovani=%d&rezim=den&datum=%@"
    
    class func getTimetableUrl() -> String {
        var url = TIMETABLE
        if(Preferences.teacherMode) {
            url = TEACHER_TIMETABLE
        }
        return String(format: url, arguments: [Preferences.id])
    }
    
    class func getSubstitutionUrl() -> String {
        var baseUrl = String(format: SUBSTITUTION_URL, Preferences.id)
        if(shouldDisplayNextSubstitution()) {
            baseUrl = String(format: SUBSTITUTION_TOMORROW_URL, Preferences.id, getNextSubstitutionDateString())
        }
        if(Preferences.teacherMode) {
            baseUrl = String(format: TEACHER_SUBSTITUTION_URL, Preferences.id)
            if(shouldDisplayNextSubstitution()) {
                baseUrl = String(format: TEACHER_SUBSTITUTION_TOMORROW_URL, Preferences.id, getNextSubstitutionDateString())
            }
        }
        return baseUrl
    }
    
    class func shouldDisplayNextSubstitution() -> Bool {
        let now = moment()
        if(now.weekday >= 5 || now.weekday == 1 || now.hour > 16) {
            return true
        }
        return false
    }
    
    class func getNextSubstitutionDateString() -> String {
        let tomorrow = moment().add(1, TimeUnit.Days)
        return tomorrow.format(dateFormat: "yyyy-MM-d")
    }
}
