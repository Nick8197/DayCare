//
//  DCChildCollectionViewCell.swift
//  DayCare
//
//  Created by Tayal, Rishabh on 3/27/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit

class DCChildCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
    }
}
