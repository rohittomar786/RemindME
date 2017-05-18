//
//  TodayViewController.swift
//  RemindMeWidget
//
//  Created by Rohit Tomar on 05/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var tableView: UITableView!

    var reminderList = [[String:AnyObject]]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        reminderList = UserDefaultsManager.getReminders() ?? []
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        if let reminders = UserDefaultsManager.getReminders() {
            reminderList = reminders
            completionHandler(.newData)
        }else {
            completionHandler(.failed)
        }
    }
    
    func widgetMarginInsetsForProposedMarginInsets
        (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
        return UIEdgeInsets.zero
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = CGSize()
        }
        else {
            let height = reminderList.count > 0 ? reminderList.count * 59 : 59
            self.preferredContentSize = CGSize(width: 0, height: height);
        }
        
    }

}


extension TodayViewController: UITableViewDelegate, UITableViewDataSource, DoneStatusChanged {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = reminderList.count > 0 ? reminderList.count : 0
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        extensionContext?.open(URL(string: "widgetReminderDemo://")!, completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WidgetTableViewCell", for: indexPath) as! WidgetTableViewCell
        cell.configure(dict: reminderList[indexPath.row],row: indexPath.row)
        cell.delegate = self
        return cell
        
    }
    
    func refreshWidget() {
        reminderList = UserDefaultsManager.getReminders() ?? []
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
