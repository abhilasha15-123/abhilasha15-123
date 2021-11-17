//
//  buttonwithImage.swift
//  Hyak
//
//  Created by mac-16 on 3/24/20.
//  Copyright © 2020 mac-16. All rights reserved.
//

import UIKit


class buttonwithImage : UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: bounds.width - 20, bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        }
    }

}
