

import UIKit
import FADesignable
import FSPagerView

class CollectionViewCell: FSPagerViewCell {

//    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.clipsToBounds = true
//        imageView.layer.cornerRadius = 30
        movieImage.layer.cornerRadius = 30

    }

}
