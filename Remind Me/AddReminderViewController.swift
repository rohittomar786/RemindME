//
//  AddReminderViewController.swift
//  RemindMe
//
//  Created by Rohit Tomar on 05/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import Foundation
import UIKit

class AddReminderViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var detailTextField: UITextField!
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        guard let title = titleTextField.text , let detail = detailTextField.text else{
             return
        }
        
        if let defaultArray =  UserDefaultsManager.getReminders() {
            var reminderArray = defaultArray
            var dict = [String:AnyObject]()
            dict.updateValue(title as AnyObject, forKey: "title")
            dict.updateValue(detail as AnyObject, forKey: "detail")
            dict.updateValue(false as AnyObject, forKey: "done")
            reminderArray.append(dict)
            UserDefaultsManager.addReminders(reminderDetails: reminderArray)
        }else {
            var reminderArray = [[String:AnyObject]]()
            var dict = [String:AnyObject]()
            dict.updateValue(title as AnyObject, forKey: "title")
            dict.updateValue(detail as AnyObject, forKey: "detail")
            dict.updateValue(false as AnyObject, forKey: "done")
            reminderArray.append(dict)
            UserDefaultsManager.addReminders(reminderDetails: reminderArray)
        }
        
        
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
