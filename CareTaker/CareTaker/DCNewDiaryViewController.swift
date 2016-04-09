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
//    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnImage(_:)))
//        imageView.addGestureRecognizer(imageTapGesture)

        let image = UIImage(named: "ic_photo_camera")
        let attachemtn = NSTextAttachment()
        attachemtn.image = image
        let attrString = NSAttributedString(attachment: attachemtn)
        textView.textStorage.insertAttributedString(attrString, atIndex: textView.selectedRange.location)
        
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
    
    func tappedOnImage(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Select Photo", message: "", preferredStyle: .ActionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (action: UIAlertAction) in
                self.showImagePicker(.Camera)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (action: UIAlertAction) in
            self.showImagePicker(.PhotoLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
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
//        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
//        let file = PFFile(data: imageData!)
//        diary.photo = file!
        diary.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            self.navigationItem.leftBarButtonItem?.enabled = true
            self.navigationItem.rightBarButtonItem?.enabled = true
            if success {
                ServiceCaller.sendPush("New post", completion: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}

extension DCNewDiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage]
//        self.imageView.image = chosenImage as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /******
    
    
    let discardMessage: String = "All Changes Will Be Lost"
    let placeHolderDescription = "Notes"
    
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var textViewContainerBottomConstraint: NSLayoutConstraint!
    var addedImage = false
    let LimitLength = 100
    var isLoading : Bool = false
    //MARK: - VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "New Note"
        self.navigationItem.leftBarButtonItem = self.closeBtn()
        
        self.noteTextView.placeholder = placeHolderDescription
        
        self.addKeyboardNotification()
        self.navigationItem.rightBarButtonItem = self.addButton()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem?.enabled = self.addBtnEnabledStatus()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.noteTextView.resignFirstResponder()
        super.viewWillDisappear(animated)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //Mark - Notification Center
    func addKeyboardNotification() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        let keyboardFrameVal = userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardFrame = keyboardFrameVal?.CGRectValue
        let animationDuration = userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        
        self.textViewContainerBottomConstraint.constant = (keyboardFrame?.size.height)!
        
        UIView.animateWithDuration(animationDuration!) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        let animationDuration = userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        
        self.textViewContainerBottomConstraint.constant = 0
        
        UIView.animateWithDuration(animationDuration!) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
    }
    
    //Mark - Navbar Appearance
    
    func addButton() -> UIBarButtonItem {
        let add: UIBarButtonItem = UIBarButtonItem(title: "ADD", style: .Plain, target: self, action: "addNoteTapped:")
        add.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGrayColor()], forState: .Disabled)
        return add
    }
    
    func uploadNote(imageUrl: String?) {
//        var noteObject = ["content": self.noteTextView.text, "title": self.titleTextField.text]
//        if let url = imageUrl {
//            noteObject["imageUrl"]  = url
//        }
//        PSCBackendUtility.addNoteToGiftBoard(self.giftBoardId, noteObject: noteObject) { (inner) -> Void in
//            do {
//                if let _ = try inner() {
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        self.view.hideLoadingIndicator()
//                        self.dismissViewControllerAnimated(true, completion: nil)
//                    })
//                } else {
//                    
//                }
//            } catch {
//                
//            }
//        }
        
    }
    
    func addNoteTapped(sender: AnyObject) {
        
        if isLoading == true {
            return
        }
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        isLoading = true
        if addedImage {
//            uploadImage({ (imageUrl) -> Void in
//                self.uploadNote(imageUrl)
//            })
        } else {
//            uploadNote(nil)
        }
    }
    
    func closeBtn() -> UIBarButtonItem {
        let closeBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ps_close_icon"), style: .Plain, target: self, action: "closeBtnPressed")
        
        return closeBtn
    }
    
    func closeBtnPressed() {
        if self.addBtnEnabledStatus() {
            let alertController: UIAlertController = UIAlertController(title: nil, message: discardMessage, preferredStyle: .Alert)
            let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                })
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    //MARK: - TextField Value Changed
    
    func addBtnEnabledStatus() -> Bool {
        if self.noteTextView.text?.characters.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    
    @IBAction func valueChanged(sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        
        if  text.characters.count > LimitLength {
            sender.deleteBackward()
        }
        
        if text.stringIsAllwhiteSpace() {
            self.navigationItem.rightBarButtonItem?.enabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = self.addBtnEnabledStatus()
        }
    }
    
    @IBAction func addImage(sender: AnyObject) {
        
        let alertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let takePicAction = UIAlertAction(title: "Take a Photo", style: .Default) { (UIAlertAction) -> Void in
            self.imageTakenFromcamera()
        }
        
        let fromLibraryAction = UIAlertAction(title: "Choose From Library", style: .Default) { (UIAlertAction) -> Void in
            self.imageTakenFromLibrary()
        }
        
        let removeAction = UIAlertAction(title: "Remove Photo", style: .Default) { (UIAlertAction) -> Void in
            self.imageBtn.setImage(UIImage(named: "ic_photo_camera_white"), forState: .Normal)
            self.addedImage = false
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(takePicAction)
        alertController.addAction(fromLibraryAction)
        alertController.addAction(cancelAction)
        if self.addedImage == true {
            alertController.addAction(removeAction)
        }
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender as? UIView
            popoverController.sourceRect = sender.bounds
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Image Picker
    func imageTakenFromcamera() {
        let pick: UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            pick.sourceType = UIImagePickerControllerSourceType.Camera
            pick.allowsEditing = true
            self .presentViewController(pick, animated: true, completion: nil)
            
        } else {
            print("Camera is not available")
        }
        
    }
    
    func imageTakenFromLibrary() {
        let pick: UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pick.allowsEditing = true
        self.presentViewController(pick, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.imageBtn.setImage(image, forState: .Normal)
        self.imageBtn.contentMode = .ScaleAspectFill
        //        picker.dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.addedImage = true
    }
    
//    func updateDisplayValue(imageUrl: String?) -> [String: AnyObject] {
//        
//        if var displayValue = giftboardItem?.displayValue {
//            displayValue["title"] = titleTextField.text
//            displayValue["content"] = noteTextView.text
//            displayValue.removeValueForKey("deleted")
//            if let url = imageUrl {
//                displayValue["imageUrl"] = url
//            } else {
//                displayValue.removeValueForKey("imageUrl")
//            }
//            print(displayValue)
//            updateGiftboardItem(imageUrl)
//            print(displayValue)
//            return displayValue
//        }
//        
//        return ["" : ""]
//    }
//    
//    func updateGiftboardItem(imageUrl: String?) {
//        
//        if let item = giftboardItem {
//            item.imagerl = imageUrl
//            item.name = self.titleTextField.text
//            item.value = noteTextView.text
//        }
//        
//        
//    }
******/
}
