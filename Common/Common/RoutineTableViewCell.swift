//
//  RoutineTableViewCell.swift
//  Common
//
//  Created by Tayal, Rishabh on 4/8/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

public class RoutineTableViewCell: UITableViewCell {

    @IBOutlet var childNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(routineObject: DCRoutine) {
        childNameLabel.text = routineObject.child.name
        dateLabel.text = routineObject.date.prettyDate()
    }
}