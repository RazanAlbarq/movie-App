//
//  ThirdCollectionViewCell.swift
//  TestApi
//
//  Created by Razan Barq on 14/01/2023.
//

import UIKit

class ThirdCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var imageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        movieImage.layer.cornerRadius = 30
    }

}
