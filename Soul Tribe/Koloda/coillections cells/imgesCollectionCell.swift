//
//  imgesCollectionCell.swift
//  Soul Tribe
//
//  Created by mac-9 on 06/07/21.
//

import UIKit

class imgesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblkm: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblkm.layer.cornerRadius = 5
        // Initialization code
    }

}
