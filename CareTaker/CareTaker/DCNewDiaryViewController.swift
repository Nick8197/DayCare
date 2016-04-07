//
//  DCNewDiaryViewController.swift
//  CareTaker
//
//  Created by Tayal, Rishabh on 4/7/16.
//  Copyright © 2016 Tayal, Rishabh. All rights reserved.
//

import UIKit
import Parse

class DCNewDiaryViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnImage(_:)))
        imageView.addGestureRecognizer(imageTapGesture)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: #selector(postDiary))
    }
    
    func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tappedOnImage(sender: AnyObject) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = true
        imagePickerVC.sourceType = .PhotoLibrary
        self.presentViewController(imagePickerVC, animated: true, completion: nil)
    }
    
    func postDiary() {
        let diary = DCDiary()
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
        let file = PFFile(data: imageData!)
        diary.photo = file!
        diary.saveInBackgroundWithBlock { (success: Bool, error: NSError?) in
            if success {
                DCServiceCaller.sendPush("New post", completion: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}

extension DCNewDiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage]
        self.imageView.image = chosenImage as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
