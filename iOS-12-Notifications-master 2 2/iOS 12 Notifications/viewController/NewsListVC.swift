//
//  NewsListVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class NewsListVC: UIViewController,SideMenuItemContent, Storyboardable {

    @IBOutlet weak var writePostBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var writeSomethingTextVw: UITextView!
    @IBOutlet weak var newsFeedTableVw: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var heightvw: NSLayoutConstraint!
    
    var arrImages = [["Title":"Sravani","Image":"Post6"],["Title":"Laxmi","Image":"Post8"],["Title":"Rama","Image":"post3"],["Title":"Laxmi","Image":"post4"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    func setUpUI()  {
        heightvw.constant = 84
        decorateBtnsView()
        addSwipeGesture()
        callingtheLocalNotificationsWithCustomView()
    }
    
    private func decorateBtnsView() {
        nameBtn.addBorderForLogoBtn()
        writeSomethingTextVw.inputAccessoryView = Utilities.getInputAccesoryView(size: CGSize(width: self.view.frame.width, height: 45), rightBtntArget: self, rightBtnAction: #selector(keyBoardDoneBtn), rightBtnText: "Done")
    }
    
    @objc private func keyBoardDoneBtn() {
        writeSomethingTextVw.endEditing(true)
    }
    
    func addSwipeGesture() {
        if revealViewController() != nil {
           // menuBtn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }
    @IBAction func menuBarBtnTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func btnMenuOnClick(_ sender: Any) {
        showSideMenu()
    }
}

extension NewsListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell") as! NewsFeedCell
        cell.vwBg.setShawdowviewColor()
        cell.vwImg.layer.cornerRadius = cell.vwImg.frame.width / 2
        cell.vwImg.layer.borderColor = UIColor(red: 233.0/255.0, green: 138.0/255.0, blue: 64.0/255.0, alpha: 1.0).cgColor
        cell.vwImg.layer.borderWidth = 2
        cell.lblPost.text = String(format: "%@ GGK Tech Posted", arrImages[indexPath.row]["Title"] ?? "")
        cell.imgPost.image = UIImage.init(named: arrImages[indexPath.row]["Image"] ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsListVC: UITextViewDelegate {
    
}
