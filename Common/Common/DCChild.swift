//
//  DCChild.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/27/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

public class DCChild: PFObject, PFSubclassing {
    
    public static func parseClassName() -> String {
        return "Child"
    }
    
    @NSManaged public var name: String
    @NSManaged public var image: String?
}
