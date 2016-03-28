//
//  DCChild.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/27/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

class DCChild: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Child"
    }
    
    @NSManaged var name: String
    @NSManaged var image: String?
}
