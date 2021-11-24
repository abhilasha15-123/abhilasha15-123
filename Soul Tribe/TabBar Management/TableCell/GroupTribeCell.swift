//
//  GroupTribeCell.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 09/06/21.
//

import UIKit

class GroupTribeCell: UITableViewCell {
    
    
    @IBOutlet weak var btn_requestToJoin: UIButton!
    @IBOutlet weak var btn_memberCount: UIButton!
    @IBOutlet weak var img_disp: UIImageView!
    
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    
    
    @IBOutlet weak var mainview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
