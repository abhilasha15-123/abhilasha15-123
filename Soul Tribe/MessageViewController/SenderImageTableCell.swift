//
//  SenderImageTableCell.swift
//  Directory Cum
//
//  Created by APPLE on 07/05/20.
//  Copyright © 2020 mac-15. All rights reserved.
//

import UIKit

class SenderImageTableCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var ProfileImgView: MyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
