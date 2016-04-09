//
//  DCNewDiaryViewController.swift
//  CareTaker
//
//  Created by Tayal, Rishabh on 4/7/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse
import UITextView_Placeholder

class DCNewDiaryViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        cameraToolbar.barStyle = .Default
        cameraToolbar.items = [UIBarButtonItem(image: UIImage.init(named: "ic_photo_size_select_actual"), style: .Plain, target: self, action: #selector(showLibaryPicker))]
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            cameraToolbar.items?.append(UIBarButtonItem(image: UIImage(named: "ic_add_a_photo"), style: .Plain, target: self, action: #selector(cameraPicker)))
        }
        cameraToolbar.sizeToFit()
        textView.inputAccessoryView = cameraToolbar
        
        textView.placeholder = "What's happening?"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: #selector(postDiary))
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedOnScreen(_:))))
    }
    
    func tappedOnScreen(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func cameraPicker() {
        showImagePicker(.Camera)
    }
    
    func showLibaryPicker() {
        showImagePicker(.PhotoLibrary)
    }
    
    //    func tappedOnImage(sender: AnyObject) {
    //        let actionSheet = UIAlertController(title: "Select Photo", message: "", preferredStyle: .ActionSheet)
    //        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
    //            actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (action: UIAlertAction) in
    //                self.showImagePicker(.Camera)
    //            }))
    //        }
    //        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (action: UIAlertAction) in
    //            self.showImagePicker(.PhotoLibrary)
    //        }))
    //        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    //        self.presentViewController(actionSheet, animated: true, completion: nil)
    //    }
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        imagePickerVC.sourceType = sourceType
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
    }
    
    func postDiary() {
        self.view.endEditing(true)
        self.navigationItem.leftBarButtonItem?.enabled = false
        self.navigationItem.rightBarButtonItem?.enabled = false
        let diary = DCDiary()
        let image = insertedImage()?.image
        let imageData = UIImageJPEGRepresentation(image!, 1)
        let file = PFFile(data: imageData!)
        diary.photo = file!
        diary.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            self.navigationItem.leftBarButtonItem?.enabled = true
            self.navigationItem.rightBarButtonItem?.enabled = true
            if success {
                ServiceCaller.sendPush("New post", completion: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func insertedImage() -> (found: Bool, range: NSRange, image: UIImage)? {
        var existingImage: (found: Bool, range: NSRange, image: UIImage)? = nil
        textView.attributedText.enumerateAttribute(NSAttachmentAttributeName, inRange: NSRange(location: 0, length:  textView.attributedText.length), options: .LongestEffectiveRangeNotRequired) { (value: AnyObject?, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
            if let value = value as? NSTextAttachment {
                if let image = value.image {
                    existingImage = (true, range, image)
                }
            }
        }
        return existingImage
    }
}

extension DCNewDiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage]
        
        let attachemtn = NSTextAttachment()
        attachemtn.image = chosenImage as? UIImage
        let attrString = NSAttributedString(attachment: attachemtn)
        
        if let existingImage = insertedImage() {
            self.textView.textStorage.replaceCharactersInRange(existingImage.range, withAttributedString: attrString)
        } else {
            self.textView.textStorage.insertAttributedString(attrString, atIndex: self.textView.selectedRange.location)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
