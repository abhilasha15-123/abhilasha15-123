//
//  SenderTableCell.swift
//  Directory Cum
//
//  Created by mac-15 on 18/12/19.
//  Copyright © 2019 mac-15. All rights reserved.
//

import UIKit

class SenderTableCell: UITableViewCell {
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    
    @IBOutlet weak var ReadImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
