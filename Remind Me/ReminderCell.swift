//
//  ReminderCell.swift
//  RemindMe
//
//  Created by Rohit Tomar on 05/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import Foundation
import UIKit

class ReminderCell: UITableViewCell {
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func configureCell(title:String, detail: String, done: Bool) {
        
        lblTitle.text = title
        lblDetail.text = detail
        if done {
            imgView.image = UIImage(named: "done")
        }else {
            imgView.image = UIImage(named: "notDone")
        }
        
    }
    
}
