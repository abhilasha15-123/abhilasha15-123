//
//  MatchListCell.swift
//  Soul Tribe
//
//  Created by Ashish Soni on 09/06/21.
//

import UIKit

class MatchListCell: UITableViewCell {
    @IBOutlet weak var cornorview: UIView!

    @IBOutlet weak var btn_redirect: UIButton!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_profile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
