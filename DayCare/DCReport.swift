//
//  DCReport.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 4/3/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

class DCReport: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return "Report"
    }
    
    @NSManaged var child: DCChild
    @NSManaged var date: NSDate
    @NSManaged var diaparing: NSDate
}
