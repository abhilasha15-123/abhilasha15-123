//
//  ExploreMeetUpcell.swift
//  Soul Tribe
//
//  Created by mac-9 on 05/07/21.
//

import UIKit
import OnlyPictures

class ExploreMeetUpcell: UITableViewCell {
    
    var arr_goingMembers = [[String:Any]]()
  
    @IBOutlet weak var constraint_width_peopleList: NSLayoutConstraint! //100
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lbldetails: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var lblgoing: UILabel!
    @IBOutlet weak var viewcornor: UIView!

 
    @IBOutlet weak var onlyImages: OnlyHorizontalPictures!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onlyImages.alignment = .left
        onlyImages.dataSource = self
        
        onlyImages.reloadData()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ExploreMeetUpcell : OnlyPicturesDataSource {
    
    // ---------------------------------------------------
    // returns the total no of pictures
    
    func numberOfPictures() -> Int {
        return arr_goingMembers.count
    }
    
    // ---------------------------------------------------
    // returns the no of pictures should be visible in screen.
    // In above preview, Left & Right formats are example of visible pictures, if you want pictures to be shown without count, remove this function, it's optional.
    
    func visiblePictures() -> Int {
        return 4
    }
    
    
    // ---------------------------------------------------
    // return the images you want to show. If you have URL's for images, use next function instead of this.
    // use .defaultPicture property to set placeholder image. This only work with local images. for URL's images we provided imageView instance, it's your responsibility to assign placeholder image in it. Check next function.
    // onlyPictures.defaultPicture = #imageLiteral(resourceName: "defaultProfilePicture")
    
//    func pictureViews(index: Int) -> UIImage {
//
//        return pictures[index]
//    }
    
    
    // ---------------------------------------------------
    // If you do have URLs of images. Use below function to have UIImageView instance and index insted of 'pictureViews(index: Int) -> UIImage'
    // NOTE: It's your resposibility to assign any placeholder image till download & assignment completes.
    // I've used AlamofireImage here for image async downloading, assigning & caching, Use any library to allocate your image from url to imageView.
    
    func pictureViews(_ imageView: UIImageView, index: Int) {
    
        let dict = arr_goingMembers[index]
        let urlStr = "\(Config().baseImageUrl)\(DataManager.getVal(dict["profile_image"]) as? String ?? "")"
       
        imageView.image = #imageLiteral(resourceName: "Ellipse 36")   // placeholder image
        imageView.sd_setImage(with: URL(string: urlStr), completed: nil)
        
    }
}

