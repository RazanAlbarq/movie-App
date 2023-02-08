
import UIKit
import Alamofire
import Kingfisher

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var arrayMovies: MoviesResponse?
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        self.getData()
        super.viewDidLoad()
        collectionMovies.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func getData() {
        AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=c499482730372cb9f5af86970b5a4853&language=en-US&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            self.arrayMovies = resJSON
                            self.collectionMovies.delegate = self
                            self.collectionMovies.dataSource = self
                            self.collectionMovies.reloadData()
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayMovies?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionMovies.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.movieLabel.text = arrayMovies?.movies?[indexPath.row].title
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(arrayMovies?.movies?[indexPath.row].posterPath ?? "")") {
            cell.movieImage?.kf.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
 
}
