//
//  ContactInfoVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import UserNotifications




class ContactInfoVC: UIViewController,SideMenuItemContent, Storyboardable {
    
    @IBOutlet weak var tblContacts: UITableView!
    @IBOutlet weak var btnAddContacts: UIButton!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var heightTbl: NSLayoutConstraint!
    @IBOutlet weak var heightOfVw: NSLayoutConstraint!
    
    let heightOfRow = 65
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI()  {
        heightOfVw.constant = 84
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        vwBg.isHidden = true
        vwBg.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        btnAddContacts.setShawdowColor()
        btnSave.setShawdowColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        heightTbl.constant = CGFloat(arrContactInfo.count * heightOfRow)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
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
    private func showAlertmessage(strMsg:String) {
        let alertController = UIAlertController(title: "",
                                                message: strMsg,
                                                preferredStyle: .alert)
        let openAction = UIAlertAction(title: "Ok", style: .default) { (action) in
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnSaveOnClick(_ sender: Any) {
        
        
        if txtName.text == "" {
            showAlert(strmsg: "Please enter name")
        }
        else if txtMobileNumber.text == "" {
            showAlert(strmsg: "Please enter mobile number")
        }
        else{
            self.view.endEditing(true)
            vwBg.isHidden = true
            
            if arrContactInfo.count == 0 {
                let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
               // callingtheLocalNotificationsWithCustomView()
            }
            
            let dictConatctInfo = NSMutableDictionary()
            dictConatctInfo.setValue(txtName.text, forKey: "name")
            dictConatctInfo.setValue(txtMobileNumber.text, forKey: "phoneNumber")
            
            arrContactInfo.add(dictConatctInfo)
            UserDefaults.standard.setValue(arrContactInfo, forKey: "ContactInfo")
            UserDefaults.standard.synchronize()
            heightTbl.constant = CGFloat(arrContactInfo.count * heightOfRow)
            tblContacts.reloadData()
            txtName.text = ""
            txtMobileNumber.text = ""
        }
        
    }
    @IBAction func btnMenuOnClick(_ sender: Any) {
        showSideMenu()
    }
    
    @IBAction func btnAddConatctsOnClick(_ sender: Any) {
        vwBg.isHidden = false
        
    }
    
    @objc func btnMenuOnClick(sender:UIButton)  {
        showSideMenu()
    }
    
    
}
extension ContactInfoVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContactInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ContactInfoCell = (tableView.dequeueReusableCell(withIdentifier: "cellContacts") as! ContactInfoCell?)!
        cell.vwBg.setShawdowviewColor()
        if let dictContacts = arrContactInfo.object(at: indexPath.row) as? NSDictionary {
            if let strname = dictContacts.value(forKey: "name") as? String {
                cell.lblName.text = strname
            }
            if let strMobile = dictContacts.value(forKey: "phoneNumber") as? String {
                cell.lblMobileNumber.text = strMobile
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightOfRow)
    }
    
    
}
