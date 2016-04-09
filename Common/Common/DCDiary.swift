//
//  DCReport.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 4/3/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

public class DCDiary: PFObject, PFSubclassing {
    
    public static func parseClassName() -> String {
        return "Diary"
    }
    
    @NSManaged public var child: DCChild
    @NSManaged public var date: NSDate
    @NSManaged public var photo: PFFile
    @NSManaged public var caption: String
}
