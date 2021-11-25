//
//  GalleryCollectionViewCell.swift
//  TuVozNow
//
//  Created by mac-14 on 05/05/20.
//  Copyright © 2020 zokoo. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumbnail.layer.cornerRadius = 6
        imgThumbnail.clipsToBounds = true
        self.contentView.layer.cornerRadius = 6
        self.contentView.clipsToBounds = true
    }

}
