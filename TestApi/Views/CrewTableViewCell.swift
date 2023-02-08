
import UIKit

class CrewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adult: UILabel!
    
    @IBOutlet weak var crewName: UILabel!
    
    @IBOutlet weak var crewImage: UIImageView!
    
    @IBOutlet weak var crewDep: UILabel!
    
    @IBOutlet weak var popularity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
