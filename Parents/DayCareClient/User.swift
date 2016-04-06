//
//  User.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import Parse

class User: PFObject, PFSubclassing {

    static func parseClassName() -> String {
        return "_User"
    }
    
    @NSManaged var child: DCChild
}
