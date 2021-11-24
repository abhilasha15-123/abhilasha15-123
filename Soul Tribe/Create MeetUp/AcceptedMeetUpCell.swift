//
//  AcceptedMeetUpCell.swift
//  Soul Tribe
//
//  Created by MAC-27 on 17/11/21.
//

import UIKit

class AcceptedMeetUpCell: UITableViewCell {

 
    @IBOutlet weak var lbl_meetupName: UILabel!
    @IBOutlet weak var lbl_imgUser: UIImageView!
    
    @IBOutlet weak var lbl_location: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
