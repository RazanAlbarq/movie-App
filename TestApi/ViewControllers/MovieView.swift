import UIKit
import SwiftyStarRatingView
import Tabman
import Pageboy
import UIGradient
import Alamofire

class MovieView: UIViewController{
    
    //MARK: - Variables
    var movie: Movie?
    var videoPlayer : Video?
    private var backgroundColor: [UIColor] = []
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gradiantView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starView: SwiftyStarRatingView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var voteCpuintLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var voteRate: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBAction func pressVideo(_ sender: Any) {
        
        if let youtubeString = videoPlayer?.results?.first?.key,
           let youtubeUrl = URL(string:"https://www.youtube.com/watch?v=\(youtubeString)") {
            if UIApplication.shared.canOpenURL(youtubeUrl) {
                UIApplication.shared.openURL(youtubeUrl)
            }
            
        }
    }
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        getMovie()
        getData()
        backgroundColor = [UIColor(red: 0.05, green: 0.15, blue: 0.25, alpha: 1.00), UIColor(red: 0.90, green: 0.89, blue: 0.89, alpha: 1.00)]
        let gradiant = GradientLayer(direction: .topToBottom, colors: backgroundColor)
//        movieNav.title = "Movies".localize()
        titleLabel.text = "Title".localize()
        overviewLabel.text = "Overview" .localize()
        voteLabel.text = "Vote Average".localize()
        voteCpuintLabel.text = "Vote Count".localize()
       
    }
    
    func getMovie() {
        movieTitle.text = movie?.title ?? ""
        movieOverview.text = movie?.overview ?? ""
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(movie?.posterPath ?? "")") {
            movieImage.kf.setImage(with: url)
        }
        voteRate.text = "\(movie?.voteAverage ?? 0)"
        voteCount.text = "\(movie?.voteCount ?? 0)"
        starView.tintColor = UIColor(red: 0.00, green: 0.71, blue: 0.89, alpha: 1.00)
        starView.value = 5
    }
    // \(movie?.id ?? 0)
    func getData() {
        AF.request( "https://api.themoviedb.org/3/movie/\(movie?.id ?? 0)/videos?api_key=c499482730372cb9f5af86970b5a4853&language=en-US" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(Video.self, from: data)
                            self.videoPlayer = resJSON
                            
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }

}

