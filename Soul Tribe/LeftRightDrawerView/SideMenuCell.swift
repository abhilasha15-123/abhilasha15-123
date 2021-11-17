//
//  SideMenuCell.swift
//  RideShare
//
//  Created by sensussoft on 1/3/18.
//  Copyright © 2018 sensussoft. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet var lblItem: UILabel!
    @IBOutlet var crown_icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //viewCounter.applyCircle()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
