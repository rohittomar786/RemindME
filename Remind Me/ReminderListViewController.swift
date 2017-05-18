//
//  ViewController.swift
//  Remind Me
//
//  Created by Rohit Tomar on 05/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import UIKit
import NotificationCenter

class ReminderListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var reminderList = [[String:AnyObject]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var widgetController = NCWidgetController()
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let addReminderVC = storyboard?.instantiateViewController(withIdentifier: "AddReminderViewController") as? AddReminderViewController
        self.navigationController?.pushViewController(addReminderVC!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ReminderListViewController.refreshUI), name: Notification.Name.cameInForeground, object: nil)
    }
    
    func refreshUI() {
        if let reminderArray = UserDefaultsManager.getReminders() {
            reminderList = reminderArray
            
        }
    }
    
    func hideShowWidget() {
        if reminderList.count == 0 {
            widgetController.setHasContent(false, forWidgetWithBundleIdentifier: "com.quovantis.rohit.Remind-Me.RemindMeWidget")
            
        }else {
            widgetController.setHasContent(true, forWidgetWithBundleIdentifier: "com.quovantis.rohit.Remind-Me.RemindMeWidget")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
        hideShowWidget()
    }
}

extension ReminderListViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reminderList.count == 0 {
            return 1
        }else {
            return reminderList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if reminderList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyReminderCell")
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? ReminderCell
            let data = reminderList[indexPath.row]
            cell?.configureCell(title: data["title"] as! String, detail: data["detail"] as! String, done: data["done"] as! Bool)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let doneAction = UITableViewRowAction(style: .normal, title: "Done", handler:  {_,_ in
            var data = self.reminderList[indexPath.row]
            data["done"] = true as AnyObject
            self.reminderList[indexPath.row] = data
            UserDefaultsManager.addReminders(reminderDetails: self.reminderList)
            self.tableView.reloadData()
        })
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler:  {_,_ in
            self.reminderList.remove(at: indexPath.row)
            UserDefaultsManager.addReminders(reminderDetails: self.reminderList)
            self.tableView.reloadData()
            self.hideShowWidget()
        })
    
        return [doneAction,deleteAction]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

