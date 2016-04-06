//
//  DCClass.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/27/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

public class DCClass: PFObject, PFSubclassing {

    public static func parseClassName() -> String {
        return "Class"
    }
    
    @NSManaged public var name: String
}
