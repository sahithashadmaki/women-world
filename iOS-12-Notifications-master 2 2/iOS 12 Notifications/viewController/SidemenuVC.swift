//
//  SidemenuVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class SidemenuVC: MenuViewController,Storyboardable {
    
    @IBOutlet weak var tblSidemenu: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    let arrviews = ["News Feed","Emergency Contacts","My Profile","Referral","Logout"]
    
    var arrViewList:[UIViewController]!
    
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSidemenu.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.none)
        arrViewList = contentControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        imgProfile.layer.cornerRadius = imgProfile.frame.width / 2
        imgProfile.clipsToBounds = true
        if (UserDefaults.standard.value(forKey: "Location_Address") != nil){
            if let strLocation = UserDefaults.standard.value(forKey: "Location_Address") as? String {
                lblAddress.text = strLocation
            }
        }
        if let strname = dictUserInfo.value(forKey: "name") as? String {
            lblName.text = strname
        }
    }
    
    private func contentControllers() -> [UIViewController] {
        
        let newsListVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsListVC") as? NewsListVC
        let contactVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactInfoVC") as? ContactInfoVC
        let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyProfileVC") as? MyProfileVC
        let referralVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReferralVC") as? ReferralVC
        
        
        return [newsListVC!,contactVC!,myProfileVC!,referralVC!]
    }
    
    
}
extension SidemenuVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SidemenuCell = (tableView.dequeueReusableCell(withIdentifier: "cellSidemenu") as! SidemenuCell?)!
        cell.lblTitle.text = arrviews[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        if (indexPath.row == 4){
            let alertController = UIAlertController(title: "",
                                                    message: "Are you sure want to logout?",
                                                    preferredStyle: .alert)
            let cancle = UIAlertAction(title: "No", style: .default) { (action) in
                menuContainerViewController.hideSideMenu()
            }
            let ok = UIAlertAction(title: "Yes", style: .default) { (action) in
                UserDefaults.standard.removeObject(forKey: "isLogin")
                UserDefaults.standard.removeObject(forKey: "UserInfo")
                UserDefaults.standard.removeObject(forKey: "ContactInfo")
                UserDefaults.standard.synchronize()
                let objLoginVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                menuContainerViewController.selectContentViewController(objLoginVC!)
                menuContainerViewController.hideSideMenu()
            }
            alertController.addAction(cancle)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        else{
            menuContainerViewController.selectContentViewController(arrViewList[indexPath.row])
            menuContainerViewController.hideSideMenu()
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}
