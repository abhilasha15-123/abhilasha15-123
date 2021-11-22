//
//  HobbiesCollectionCell.swift
//  Soul Tribe
//
//  Created by MAC-30 on 22/11/21.
//

import UIKit

class HobbiesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var hob_Title: UILabel!
    @IBOutlet weak var hob_Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ContentView.layer.cornerRadius = 8
        // Initialization code
    }
}
