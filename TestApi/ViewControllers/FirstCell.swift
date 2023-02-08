//
//  FirstCell.swift
//  TestApi
//
//  Created by Razan Barq on 06/12/2022.
//

import UIKit

class FirstCell: UITableViewCell {
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var personName: UILabel!
    
    @IBOutlet weak var popularity: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

