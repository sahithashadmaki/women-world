//
//  NotificationViewController.swift
//  Notification Content App Extension
//
//  Created by Supraja Darisa on 2/03/19.
//

import UIKit
// #3.1 - import notification SDKs
import UserNotifications
import UserNotificationsUI

// #3.2 - adopt a protocol that let's us intercept
// notifications
class NotificationViewController: UIViewController, UNNotificationContentExtension {

    // #3.3 - these outlets allow me to animate buttons
    @IBOutlet weak var clearedTransactionLabel: UILabel!
    @IBOutlet weak var coverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        
        // #3.4 - hide this label initially;
        // we'll only show it if "Cover" is tapped
        clearedTransactionLabel.alpha = 0.0
    }
    
    // #3.5 - called when a notification is received;
    // a good opportunity to decrypt things like
    // account or transaction numbers from the payload;
    // also good for parsing any other info, like the amount
    // to cover, out of the payload
    func didReceive(_ notification: UNNotification) {
        print("Extension received notification.")
    }
    
    // #3.6 - called when the user clicks "Cover"
    // in the notification; we could build a
    // payload to call a REST API to send
    // the transaction to cover the overdraft
    @IBAction func coverButtonTapped(_ sender: Any) {
        
        self.coverButton.setTitle("Message sent", for: .normal)
        let escapedString = "http://wwfinal20190228070530.azurewebsites.net/api/SendMessage"
        
        guard let nonNullUrl = URL(string: escapedString) else {
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: nonNullUrl)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        
        let body = prepareBodyForRequest()
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error)
            return
        }
        
        let task = session.dataTask(with:request) { (data, response, error) in
            
            DispatchQueue.main.async { [weak self] in
                self?.coverButton.setTitle("Message Sent", for: .normal)
            }
        }
        
        task.resume()
        
    }
    
    func prepareBodyForRequest() -> [String: Any] {
        
        var bodyDict = [String: Any]()
        
        if let arrcontacts = UserDefaults.standard.value(forKey: "ContactInfo") as? NSArray,
            let locationDetails = UserDefaults.standard.value(forKey: "Location_Address") as? String,let dictUserInfo = UserDefaults.standard.value(forKey: "UserInfo") as? NSDictionary {
            var strContacts = [String]()
            
            for dictContact in arrcontacts {
                
                if let dictObj = dictContact as? [String: Any], let number = dictObj["phoneNumber"] as? String {
                    strContacts.append(number)
                }
                bodyDict["UserName"] = dictUserInfo["name"] as? String ?? "No Name provided"
                bodyDict["Location"] = locationDetails
                bodyDict["EmergencyCallList"] = strContacts.joined(separator: ",")
                bodyDict["UserContactNumber"] = ""
            }
            
        }
        return bodyDict
    }
    
} // end class NotificationViewController
