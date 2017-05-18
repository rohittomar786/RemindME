//
//  UserDefaultsManager.swift
//  RemindMe
//
//  Created by Rohit Tomar on 05/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    private static let reminderKey:String = "reminderKey"
    
    class func addReminders(reminderDetails: [[String:AnyObject]]) {
        UserDefaults(suiteName: "group.com.quovantis.RemindMe")?.set(reminderDetails, forKey: reminderKey)
    }
    
    class func getReminders() -> [[String:AnyObject]]? {
        let value =  UserDefaults(suiteName: "group.com.quovantis.RemindMe")?.value(forKey: reminderKey)
        return value as? [[String:AnyObject]]
    }
    
}
