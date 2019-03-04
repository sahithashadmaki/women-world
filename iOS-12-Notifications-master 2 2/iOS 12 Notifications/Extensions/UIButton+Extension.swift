//
//  UIButton+Extension.swift
//  iOS 12 Notifications
//
//  Created by GGKU3MAC046 on 02/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func addBorderToButton() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func addBorderForLogoBtn() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
