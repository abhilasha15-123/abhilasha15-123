//
//  ExploreMeetUpcell.swift
//  Soul Tribe
//
//  Created by mac-9 on 05/07/21.
//

import UIKit

class ExploreMeetUpcell: UITableViewCell {
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldetails: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var lblgoing: UILabel!
    @IBOutlet weak var viewcornor: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
