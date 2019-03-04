//
//  Utilities.swift
//  iOS 12 Notifications
//
//  Created by GGKU3MAC046 on 02/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import Foundation
import UIKit


class Utilities: NSObject {
    static func getInputAccesoryView(size: CGSize, rightBtntArget:Any?,
                                     rightBtnAction:Selector, rightBtnText:String) -> UIView {
        
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let accessory = UIView(frame: frame)
        accessory.backgroundColor = UIColor.lightGray
        accessory.alpha = 1
        accessory.translatesAutoresizingMaskIntoConstraints = false
        let rightButton = UIButton(type: .custom)
        rightButton.backgroundColor = UIColor.clear
        rightButton.setTitle(rightBtnText, for: .normal)
        rightButton.addTarget(rightBtntArget, action: rightBtnAction, for: .touchUpInside)
        rightButton.showsTouchWhenHighlighted = true
        rightButton.isEnabled = true
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        accessory.addSubview(rightButton)
        let sendTrailingConstraint = NSLayoutConstraint(item: rightButton, attribute: .trailing, relatedBy: .equal, toItem: accessory, attribute: .trailing, multiplier: 1.0, constant: -20)
        accessory.addConstraint(sendTrailingConstraint)
        let sendCenterYConstraint = NSLayoutConstraint(item: rightButton, attribute: .centerY, relatedBy: .equal, toItem: accessory, attribute: .centerY, multiplier: 1.0, constant: 0)
        accessory.addConstraint(sendCenterYConstraint)
        return accessory
    }
}
