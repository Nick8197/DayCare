//
//  Utilities.swift
//  Common
//
//  Created by Tayal, Rishabh on 4/7/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
}

extension UIView {
    public func roundView(cornerRadius: CGFloat?) {
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        } else {
            self.layer.cornerRadius = self.frame.size.height / 2
        }
        self.layer.masksToBounds = true
    }
    
    public func applyShadow() {
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowColor = UIColor.darkGrayColor().CGColor
        self.layer.shadowRadius = 4
    }
}