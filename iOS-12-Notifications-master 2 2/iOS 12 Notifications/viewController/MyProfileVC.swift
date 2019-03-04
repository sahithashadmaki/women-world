//
//  MyProfileVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit
import InteractiveSideMenu


class MyProfileVC: UIViewController,SideMenuItemContent, Storyboardable {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailaddress: UITextField!
    
    @IBOutlet weak var txtMobilenumber: UITextField!
    @IBOutlet weak var txtSecuritycode: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var heightVw: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func btnSaveOnClick(_ sender: Any) {
        if txtName.text == "" {
            showAlert(strmsg:"Please enter the name")
        }
        else if txtMobilenumber.text == "" {
            showAlert(strmsg:"Please enter the mobile number")
        }
        else {
            
        }
    }
    
    
    func setUpUI() {
        heightVw.constant = 84
        
        
        if let strname = dictUserInfo.value(forKey: "name") as? String {
            txtName.text = strname
        }
        if let strEmailaddress = dictUserInfo.value(forKey: "email") as? String {
            txtEmailaddress.text = strEmailaddress
        }
        if let strMobile = dictUserInfo.value(forKey: "mobileNumber") as? String {
            txtMobilenumber.text = strMobile
        }
        if let strsecuriycode = dictUserInfo.value(forKey: "securityCode") as? String {
            txtSecuritycode.text = strsecuriycode
        }
        txtEmailaddress.isUserInteractionEnabled = false
        txtSecuritycode.isUserInteractionEnabled = false
        
    }
    
    @IBAction func btnMenuOnClick(_ sender: Any) {
        showSideMenu()
    }
    
    
}
