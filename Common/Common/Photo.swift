//
//  NYTPhoto.swift
//  Common
//
//  Created by Tayal, Rishabh on 4/9/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import NYTPhotoViewer

public class Photo: NSObject, NYTPhoto {
    
    public var image: UIImage?
    public var imageData: NSData?
    public var placeholderImage: UIImage?
    public let attributedCaptionTitle: NSAttributedString?
    public let attributedCaptionSummary: NSAttributedString? = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    public let attributedCaptionCredit: NSAttributedString? = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
    
    public init(imageData: NSData?, attributedCaptionTitle: NSAttributedString?) {
        self.imageData = imageData
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }
    
    public init(image: UIImage, attributedCaptionTitle: NSAttributedString?) {
        self.image = image
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }
    
    convenience init(attributedCaptionTitle: NSAttributedString) {
        self.init(imageData: nil, attributedCaptionTitle: attributedCaptionTitle)
    }
}
