//
//  NewsFeedCell.swift
//  iOS 12 Notifications
//
//  Created by GGKU3MAC046 on 02/03/19.
//  Copyright © 2019 Andrew Jaffee. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {

    
    @IBOutlet weak var vwImg: UIView!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var vwBg: UIView!
    
    @IBOutlet weak var lblPost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
