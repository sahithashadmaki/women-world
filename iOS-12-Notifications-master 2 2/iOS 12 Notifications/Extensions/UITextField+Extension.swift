//
//  UITextField+Extension.swift
//  iOS 12 Notifications
//
//  Created by GGKU3MAC046 on 02/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func addBorderToTextField() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

extension UITextView {
    func addBorderToTextView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
