//
//  SubmitRoutineViewController.swift
//  DayCareClient
//
//  Created by Tayal, Rishabh on 4/5/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import XLForm
import Parse

class SubmitRoutineViewController: XLFormViewController {
    
    private struct Tags {
        static let Feeding = "feeding"
        static let Napped = "napped"
        static let Diaparing = "diaparing"
        
        //        static let Age = "age"
        //        static let Image = "image"
        //        static let SecondImage = "secondImage"
        //        static let ZipCode = "zipCode"
        //        static let ActivityType = "activityType"
        //        static let Gender = "gender"
        //        static let Location = "location"
        //        static let Comments = "comments"
    }
    
    var child: DCChild!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialForm()
        let user = User.currentUser()
        user?.child.fetchIfNeededInBackgroundWithBlock({ (child: PFObject?, error: NSError?) in
            self.child = child as! DCChild
            print(self.child.name)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelTapped:")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "doneTapped:")
    }
    
    func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doneTapped(sender: AnyObject) {
        
        let reportObj = DCDiary()
        reportObj.child = child
        reportObj.diaparing = NSDate()
        reportObj.date = NSDate()
        reportObj.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
//            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func initialForm() {
        
        let form: XLFormDescriptor
        var section: XLFormSectionDescriptor
        var row: XLFormRowDescriptor
        
        form = XLFormDescriptor()
        form.addAsteriskToRequiredRowsTitle = true
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Feeding time")
        form.addFormSection(section)
        
        // Feeding
        row = XLFormRowDescriptor(tag: Tags.Feeding, rowType: XLFormRowDescriptorTypeTimeInline, title: "Feeding")
        row.value = NSDate()
        row.required = true
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Napped")
        form.addFormSection(section)
        
        //Napped
        row = XLFormRowDescriptor(tag: Tags.Napped, rowType: XLFormRowDescriptorTypeTimeInline, title: "Napped")
        row.value = NSDate()
        row.required = false
        section.addFormRow(row)
        
        section = XLFormSectionDescriptor.formSectionWithTitle("Diaparing")
        form.addFormSection(section)
        
        //Diaparing
        row = XLFormRowDescriptor(tag: Tags.Diaparing, rowType: XLFormRowDescriptorTypeTimeInline, title: "Diaparing")
        row.value = NSDate()
        row.required = false
        section.addFormRow(row)
        
        //        section = XLFormSectionDescriptor.formSectionWithTitle("")
        //        form.addFormSection(section)
        //
        //        // Age
        //        row = XLFormRowDescriptor(tag: Tags.Age, rowType:XLFormRowDescriptorTypeSelectorPickerView, title:"Age")
        //        row.selectorOptions = ["0-10", "11-18", "19-25", "26-35", "36-50"]
        //        section.addFormRow(row)
        //
        //        //Gender
        //        row = XLFormRowDescriptor(tag: Tags.Gender, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl, title: "Gender")
        //        row.selectorOptions = ["Male", "Female", "Multiple"]
        //        section.addFormRow(row)
        //
        //        // Zip Code
        //        row = XLFormRowDescriptor(tag: Tags.ZipCode, rowType: XLFormRowDescriptorTypeZipCode, title: "Zip Code")
        //        row.cellConfig.setObject(NSTextAlignment.Right.rawValue, forKey: "textField.textAlignment")
        //        section.addFormRow(row)
        //
        //        //Activity
        //        row = XLFormRowDescriptor(tag: Tags.ActivityType, rowType: XLFormRowDescriptorTypeSelectorPickerView, title: "Activity Type")
        //        row.selectorOptions = ["Solicitation", "Exploitation", "Under Age", "Other"]
        //        row.required = true
        //        section.addFormRow(row)
        //
        //        section = XLFormSectionDescriptor.formSectionWithTitle("Location")
        //        form.addFormSection(section)
        //
        //        //Location
        //        row = XLFormRowDescriptor(tag: Tags.Location, rowType: XLFormRowDescriptorTypeBooleanSwitch, title: "Location")
        //        section.addFormRow(row)
        //
        //        section = XLFormSectionDescriptor.formSectionWithTitle("Images")
        //        form.addFormSection(section)
        //
        //        //Image
        //        row = XLFormRowDescriptor(tag: Tags.Image, rowType: XLFormRowDescriptorTypeImage, title: "Image")
        //        row.value = UIImage(named: "default_avatar")
        //        let frame = CGRectMake(0, 0, 180, 180)
        //        row.cellConfig.setObject(NSValue(CGRect: frame), forKey: "imageView.frame")
        //        section.addFormRow(row)
        //
        //        section = XLFormSectionDescriptor.formSectionWithTitle("Comments")
        //        form.addFormSection(section)
        //
        //        // Notes
        //        row = XLFormRowDescriptor(tag: Tags.Comments, rowType: XLFormRowDescriptorTypeTextView)
        //        row.cellConfigAtConfigure["textView.placeholder"] = "Comments"
        //        section.addFormRow(row)
        
        self.form = form
    }
    
}