//
//  DiaryTableViewCell.swift
//  Common
//
//  Created by Tayal, Rishabh on 4/8/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

public class DiaryTableViewCell: UITableViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.cardView.roundView(4)
        self.cardView.applyShadow()
    }
    
    public func configure(diaryObject: DCDiary) {
        nameLabel.text = diaryObject.child.name
        dateLabel.text = diaryObject.date.description
        let file = diaryObject.photo
        file.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
            if let data = data {
                self.photoImageView.image = UIImage(data: data)
            }
        }
    }
}