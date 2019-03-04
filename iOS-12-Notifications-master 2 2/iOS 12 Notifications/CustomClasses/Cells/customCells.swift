//
//  customCells.swift
//  iOS 12 Notifications
//
//  Created by GGKU4MACMINI004 on 01/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var vwBg: UIView!
    
    
    @IBOutlet weak var btnCall: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

class SidemenuCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwSelected: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        vwSelected.backgroundColor = selected ? UIColor(red: 233.0/255.0, green: 138.0/255.0, blue: 64.0/255.0, alpha: 1.0) : UIColor.clear
        lblTitle.textColor = selected ? UIColor.black : UIColor.black

    }
    
}
