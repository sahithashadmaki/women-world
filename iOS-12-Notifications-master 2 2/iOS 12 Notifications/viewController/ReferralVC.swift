//
//  ReferralVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit
import InteractiveSideMenu


class ReferralVC: UIViewController,SideMenuItemContent, Storyboardable {
    
    var documentInteractionController: UIDocumentInteractionController = UIDocumentInteractionController()
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailaddress: UITextField!
    @IBOutlet weak var btnsubmit: UIButton!
    @IBOutlet weak var heightVw: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpUI()  {
        heightVw.constant = 84
        btnsubmit.setShawdowColor()
        for i in 1...2 {
            let vw = self.view.viewWithTag(i) as! UIView
            vw.setBoarder()
        }
    }
    
    @IBAction func btnMenuOnClick(_ sender: Any) {
        showSideMenu()
    }
    
    @IBAction func btnSaveOnClick(_ sender:Any){
        
        if txtName.text == "" {
            showAlert(strmsg: "Please enter the name")
        }
        else if txtEmailaddress.text == "" {
            showAlert(strmsg: "Please enter the email ")
        }
        else if txtEmailaddress.text?.isValidEmail() == false {
            showAlert(strmsg: "Please enter valid email")
        }
        else{
            let randomInt = NSUUID().uuidString
            let originalString = String(format: "I'm inviting you to be a part of Women World. Be secure and contibute to empowerment. Use this security code to signup %d", randomInt)
            let escapedString = originalString.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
            
            let url  = URL(string: "whatsapp://send?text=\(escapedString!)")
            
            if UIApplication.shared.canOpenURL(url! as URL)
            {
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}
