
import UIKit
import Alamofire
import Kingfisher

class HomeView: UIViewController {
   
    @IBOutlet weak var nowPlayingCollection: UICollectionView!
    
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    @IBOutlet weak var upComingLabel: UILabel!
    
    @IBOutlet weak var upComingCollection: UICollectionView!
    
    @IBOutlet weak var latestLabel: UILabel!
    
    @IBOutlet weak var latestCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
   /* func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = nowPlayingCollection.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.movieLabel.text = nowMovies[indexPath.row]?.title ?? ""
       return cell
    
    }
   */
    
}
