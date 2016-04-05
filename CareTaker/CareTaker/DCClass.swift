//
//  DCClass.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/27/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

class DCClass: PFObject, PFSubclassing {

    static func parseClassName() -> String {
        return "Class"
    }
    
    @NSManaged var name: String
}
