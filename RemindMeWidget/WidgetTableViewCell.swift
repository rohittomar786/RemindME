//
//  WidgetTableViewCell.swift
//  RemindMe
//
//  Created by Rohit Tomar on 06/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import UIKit

protocol DoneStatusChanged: class {
    
    func refreshWidget()

}

class WidgetTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var statusImage: UIButton!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    

    var row = 0
    var delegate:DoneStatusChanged!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        visualEffectView.effect = UIVibrancyEffect.widgetPrimary()

    }
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        var reminderList = UserDefaultsManager.getReminders()
        var data = reminderList?[row]
        
        if let _ = data {
            data?["done"] = true as AnyObject
            reminderList?[row] = (data)!
            UserDefaultsManager.addReminders(reminderDetails: reminderList!)
            delegate.refreshWidget()
        }
    }

    func configure(dict: [String:AnyObject], row: Int) {
        lblTitle.text = dict["title"] as? String
        lblDetail.text = dict["detail"] as? String
        let done = dict["done"] as? Bool
        self.row = row
        
        if done! {
            statusImage.setImage(UIImage(named: "done"), for: .normal)
        }else {
            statusImage.setImage(UIImage(named: "notDone"), for: .normal)
        }
        
    }
    
}
