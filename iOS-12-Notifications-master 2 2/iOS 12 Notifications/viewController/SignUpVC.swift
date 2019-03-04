//
//  SignUpVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

enum AttachmentType: String{
    case camera, video, photoLibrary
}

class SignUpVC: UIViewController,UIPickerViewDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtsecuritycode: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSignUp: UIButton!
    //static let shared = AttachmentHandler()
    fileprivate var currentVC: UIViewController?
    
    var imagePickedBlock: ((UIImage) -> Void)?
    var videoPickedBlock: ((NSURL) -> Void)?
    var filePickedBlock: ((URL) -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    func setUpUI()  {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.title = "Sign Up"
        txtMobileNumber.keyboardType = .namePhonePad
        
        btnSignUp.setShawdowColor()
        imgProfile.layer.cornerRadius = imgProfile.frame.width / 2
        imgProfile.clipsToBounds = true
        for i in 1...5 {
            let vw = self.view.viewWithTag(i) as! UIView
            vw.setBoarder()
        }
    }
    
    
    func addImages()  {
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .camera, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "phoneLibrary", style: .default, handler: { (action) -> Void in
            self.authorisationStatus(attachmentTypeEnum: .photoLibrary, vc: self.currentVC!)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func authorisationStatus(attachmentTypeEnum: AttachmentType, vc: UIViewController){
        
        if attachmentTypeEnum ==  AttachmentType.camera{
            self.openCamera()
        }else if attachmentTypeEnum == AttachmentType.photoLibrary {
            photoLibrary()
        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            // myPickerController.delegate = self
            myPickerController.sourceType = .camera
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            // myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentVC?.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        currentVC?.present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("url", url)
        self.filePickedBlock?(url)
    }
    
    //    Method to handle cancel action.
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        //        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        //            self.imagePickedBlock?(image)
        //        } else{
        //            print("Something went wrong in  image")
        //        }
        
        currentVC?.dismiss(animated: true, completion: nil)
    }
    
    
    //MARk: Button Actions
    
    @IBAction func btnProfileonClick(_ sender: Any) {
        
    }
    @IBAction func btnSignUpOnClick(_ sender: Any) {
        self.view.endEditing(true)
        if txtName.text == "" {
            showAlert(strmsg: "Please enter the name")
        }
        else if txtEmail.text == "" {
            showAlert(strmsg: "Please enter the Email address")
        }
        else if txtEmail.text?.isValidEmail() == false {
            showAlert(strmsg: "Please enter valid emaill")
        }
        else if txtMobileNumber.text == "" {
            showAlert(strmsg: "Please enter the Mobile number")
        }
        else if txtsecuritycode.text == "" {
            showAlert(strmsg: "Please enter the Security")
        }
        else if txtPassword.text == ""{
            showAlert(strmsg: "Please enter the password")
        }
        else{
            let dictUserInfo = NSMutableDictionary()
            dictUserInfo.setValue(txtName.text, forKey: "name")
            dictUserInfo.setValue(txtEmail.text, forKey: "email")
            dictUserInfo.setValue(txtMobileNumber.text, forKey: "mobileNumber")
            dictUserInfo.setValue(txtsecuritycode.text, forKey: "securityCode")
            UserDefaults.standard.set(dictUserInfo, forKey: "UserInfo")
            UserDefaults.standard.synchronize()
            showAlert(strmsg: "Signup successful.Please login..")
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
