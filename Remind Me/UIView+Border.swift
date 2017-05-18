//
//  UIView+Border.swift
//  RemindMe
//
//  Created by Rohit Tomar on 06/04/17.
//  Copyright © 2017 Quovantis Technologies. All rights reserved.
//

import Foundation
import  UIKit


extension Notification.Name {
    static let cameInForeground = Notification.Name("cameInForeground")
    
}

extension UIView {
    
    @IBInspectable var borderColor:UIColor {
        
        get{
            return UIColor(cgColor: layer.borderColor!)
        }
        
        set{
            layer.borderColor = newValue.cgColor
        }
        
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
}
