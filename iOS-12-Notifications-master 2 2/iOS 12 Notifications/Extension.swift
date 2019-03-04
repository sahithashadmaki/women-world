//
//  Extension.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


public var arrContactInfo = NSMutableArray()
public var dictUserInfo = NSMutableDictionary()
public var location = String()

func showAlert(strmsg:String)  {
    let alert = UIAlertView.init(title: "", message: strmsg, delegate: nil, cancelButtonTitle: "Ok")
    alert.show()
}

func callingtheLocalNotificationsWithCustomView()  {
 
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        
        guard settings.authorizationStatus == .authorized else { return }
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "debitOverdraftNotification"
        content.title = "Women World..!"
        content.subtitle = "Hope you are safe..."
        content.body = "Please press the alert button when you are in danger."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
      }
}

extension UIButton {
    
    func setShawdowColor()  {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
    
}

extension UIView {
    
    func setBoarder()  {
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setShawdowviewColor()  {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
}

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
