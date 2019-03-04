//
//  HomeVC.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreLocation
import UserNotifications



class HomeVC: MenuContainerViewController,CLLocationManagerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    func setUpUI()  {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let screenSize: CGRect = UIScreen.main.bounds
        
        if let arrcontacts = UserDefaults.standard.value(forKey: "ContactInfo") as? NSArray {
            arrContactInfo = arrcontacts.mutableCopy() as! NSMutableArray
        }
        if let userinfo = UserDefaults.standard.value(forKey: "UserInfo") as? NSArray {
            dictUserInfo = userinfo as! NSMutableDictionary
        }
        if (arrContactInfo.count > 0) {
            let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "debitOverdraftNotification", actions: [], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
           // callingtheLocalNotificationsWithCustomView()
        }
        self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)
        let sidemenuObj = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SidemenuVC") as? SidemenuVC
        self.menuViewController = sidemenuObj!
        self.contentViewControllers = contentControllers()
        self.selectContentViewController(contentViewControllers.first!)
        self.currentItemOptions.cornerRadius = 10.0
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Options to customize menu transition animation.
        var options = TransitionOptions()
        
        // Animation duration
        options.duration = size.width < size.height ? 0.4 : 0.6
        
        // Part of item content remaining visible on right when menu is shown
        options.visibleContentWidth = size.width / 6
        self.transitionOptions = options
    }
    
    private func contentControllers() -> [UIViewController] {
        
        let newsListVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsListVC") as? NewsListVC
        let contactVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactInfoVC") as? ContactInfoVC
        let myProfileVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyProfileVC") as? MyProfileVC
        let referralVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReferralVC") as? ReferralVC
        
        
        return [newsListVC!,contactVC!,myProfileVC!,referralVC!]
    }
    
    private func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK:- Location Access
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation :CLLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            if let placemarkObj = placemarks {
                let placemark =  placemarkObj as [CLPlacemark]
                if placemark.count > 0{
                    let placemark = placemarks![0]
                    
                    let strLocation = String(format: "%@,%@,%@,%@,%@,%@", placemark.locality!,placemark.subLocality!,placemark.administrativeArea!,placemark.subAdministrativeArea!,placemark.postalCode!,placemark.country!)
                    location = strLocation
                    UserDefaults.standard.setValue(strLocation, forKey: "Location_Address")
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
}
