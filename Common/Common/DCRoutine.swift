//
//  DCRoutine.swift
//  Common
//
//  Created by Tayal, Rishabh on 4/7/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

public class DCRoutine: PFObject, PFSubclassing {
    
    public static func parseClassName() -> String {
        return "Routine"
    }
    
    @NSManaged public var child: DCChild
    @NSManaged public var diaparing: NSDate
    @NSManaged public var date: NSDate
    @NSManaged public var napTiming: NSDate
    @NSManaged public var foodTiming: NSDate
}
