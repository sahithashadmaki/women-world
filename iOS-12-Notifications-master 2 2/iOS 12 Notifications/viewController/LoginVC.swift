//
//  LoginVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnsignUp: UIButton!
    
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setUpUI()
    }
    func addLeftNavigationButton()  {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = nil
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Menu"), for: .normal)
        button.addTarget(self, action:#selector(self.btnMenuOnClick(sender:)), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        self.navigationItem.title = "Contact Info"
    }
    func setUpUI()  {
        imgZoomIn()
        for i in 1...2 {
            let vw = self.view.viewWithTag(i) as! UIView
            vw.setBoarder()
        }
        self.btnLogin.setShawdowColor()
    }
    func imgZoomIn()  {
        let screenCenter = CGPoint(x:UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        let subviewCenter = self.view.convert(self.imgLogo.center, to: self.view)
        let offset = UIOffset(horizontal: screenCenter.x-subviewCenter.x, vertical: screenCenter.y-subviewCenter.y)
        
        let widthScale = UIScreen.main.bounds.size.width/imgLogo.frame.size.width
        let heightScale = UIScreen.main.bounds.size.height/imgLogo.frame.size.height
        UIView.animate(withDuration: 0, animations: {
            let scaleTransform = CGAffineTransform(scaleX: widthScale, y: heightScale)
            let translateTransform = CGAffineTransform(translationX: offset.horizontal, y: offset.vertical)
            self.imgLogo.transform = scaleTransform.concatenating(translateTransform)
        }, completion: { (check) in
        })
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imgLogo.transform = CGAffineTransform.identity
        }, completion: { (check) in
            
            if check {
                for i in 1...2 {
                    let vw = self.view.viewWithTag(i) as! UIView
                    vw.isHidden = false
                }
                self.btnLogin.isHidden = false
                self.btnsignUp.isHidden = false
            }
        })
    }
    
    @objc func btnMenuOnClick(sender:UIButton)  {
        
    }
    
    //MARK:- Button Actions
    @IBAction func btnSignUpOnClick(_ sender: Any) {
        
    }
    
    @IBAction func btnLoginOnClick(_ sender: Any) {
        if txtUsername.text == "" {
            showAlert(strmsg: "Please enter the username")
        }
        else if txtUsername.text?.isValidEmail() == false {
            showAlert(strmsg: "Please enter valid emaill")
        }
        else if txtPassword.text == "" {
            showAlert(strmsg: "Please enter the password")
        }
        else{
            if (UserDefaults.standard.value(forKey: "UserInfo") != nil) {
                if let dictInfo = UserDefaults.standard.value(forKey: "UserInfo") as? NSDictionary{
                    dictUserInfo = dictInfo as! NSMutableDictionary
                }
                let HomeVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                self.navigationController?.pushViewController(HomeVC!, animated: true)
                UserDefaults.standard.set(true, forKey: "isLogin")
                UserDefaults.standard.synchronize()
            }
            else{
                showAlert(strmsg: "There is no account please create new account")
            }
        
        }
    }
    
    
}
