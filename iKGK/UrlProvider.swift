//
//  UrlProvider.swift
//  iKGK
//
//  Created by Matouš Hýbl on 19/04/15.
//  Copyright (c) 2015 KGK. All rights reserved.
//

import Foundation

class UrlProvider {
    
    static let MARKS = "http://www.gymkyjov.cz/isas/prubezna-klasifikace.php"
    static let MOODLE = "http://www.gymkyjov.cz/moodle"
    static let CANTEEN = "http://www.gymkyjov.cz:8082"
    static let WEBSITE = "http://www.gymkyjov.cz/"
    
    static let TIMETABLE = "http://www.gymkyjov.cz/isas/rozvrh-hodin.php?zobraz=tridy-1&rozvrh=%d"
    static let TEACHER_TIMETABLE = "http://www.gymkyjov.cz/isas/rozvrh-hodin.php?zobraz=ucitel&rozvrh=%d"
    
    class func getTimetableUrl() -> String {
        var url = TIMETABLE
        if(Preferences.teacherMode) {
            url = TEACHER_TIMETABLE
        }
        return String(format: url, arguments: [Preferences.id])
    }
}
