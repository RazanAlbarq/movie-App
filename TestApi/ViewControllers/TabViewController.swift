

import UIKit
import Tabman
import Pageboy

class TabViewController: UIViewController  {
    
    var movie: Movie?
    
    @IBOutlet weak var movieContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let container = segue.destination as? MovieContainerView {
            container.movie = self.movie
        }

    }
    
    
}
