//
//  BusinessCell.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class BusinessCell: UICollectionViewCell {
    
    @IBOutlet weak var businessLogo: UIImageView!
    @IBOutlet weak var businessCard: UIView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessSchedule: UILabel!
    
    /*override init(frame: CGRect) {
        businessLogo.layer.borderWidth = 1.0
        businessLogo.layer.masksToBounds = false
        businessLogo.layer.borderColor = UIColor.white as! CGColor
        businessLogo.layer.cornerRadius = frame.size.width/2
        businessLogo.clipsToBounds = true
    }*/
}
