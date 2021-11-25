//
//  MessageListCell.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 09/06/21.
//

import UIKit

class MessageListCell: UITableViewCell {
    @IBOutlet weak var cornorview: UIView!
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_msg: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var showStoryBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
