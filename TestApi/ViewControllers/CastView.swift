//
//  CastView.swift
//  TestApi
//
//  Created by Razan Barq on 28/12/2022.
//

import UIKit
import Alamofire
import Kingfisher

// 3714087
class CastView: UIViewController {
    
    var person: Result1?
    var cast: Cast?
    var arrayMovies: CastMovies?
    var movie: Movie?


    
    
    @IBOutlet weak var castImage: UIImageView!
    
    @IBOutlet weak var castLabel: UILabel!
    
    @IBOutlet weak var birthdayCast: UILabel!
    
    @IBOutlet weak var castDep: UILabel!
    
    @IBOutlet weak var birthdayPlace: UILabel!
    
    @IBOutlet weak var biography: UILabel!

    @IBOutlet weak var collectionView: UICollectionView!
    
   
//    {
//        didSet {
//            self.collectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SecondCollectionViewCell")
//        }
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CastCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CastCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.getData()
        self.getData2()
    }
    
    func getInfo() {
        castImage.layer.cornerRadius = 20
        castLabel.text = cast?.name
        biography.text = cast?.biography
        birthdayPlace.text = cast?.placeOfBirth
        birthdayCast.text = cast?.birthday
        castDep.text = cast?.knownForDepartment
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(person?.profilePath ?? "/oTB9vGIBacH5aQNS0pUM74QSWuf.jpg")") {
            castImage.kf.setImage(with: url)
        }
    }
    
    func getData() {
        AF.request( "https://api.themoviedb.org/3/person/\(person?.id ?? 0)?api_key=c499482730372cb9f5af86970b5a4853&language=en-US" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(Cast.self, from: data)
                            self.cast = resJSON
                            self.getInfo()
                            self.collectionView.reloadData()
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }
    func getData2() {
        AF.request( "https://api.themoviedb.org/3/person/\(person?.id ?? 0)/movie_credits?api_key=c499482730372cb9f5af86970b5a4853&language=en-US" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(CastMovies.self, from: data)
                            self.arrayMovies = resJSON
                            self.collectionView.reloadData()
                        }
                    } catch(let error) {
                        print(error.localizedDescription)
                    }
                case .failure(_):
                    print("")
                }
            })
    }
    
}

extension CastView: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.bounds.height + 20
        let h = collectionView.bounds.height
        return CGSize(width: w, height: h)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if !(arrayMovies?.cast?.isEmpty ?? true) {
            return arrayMovies?.cast?.count ?? 0
        }
        else {
            return arrayMovies?.crew?.count ?? 0

        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as! CastCell
        
        if arrayMovies?.crew != nil && !(arrayMovies?.crew?.isEmpty ?? true) && (arrayMovies?.cast?.isEmpty ?? true){
//            movie = arrayMovies?.crew[index]
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(arrayMovies?.crew?[indexPath.row].posterPath ?? "")" ?? "/ey2wVKxujc8rYbnGtg8w3DvJpiA.jpg" ) {
                cell.movieImage.kf.setImage(with: url)
            }
            return cell
        }
        else {
            if let url = URL(string:"https://image.tmdb.org/t/p/w500\(arrayMovies?.cast?[indexPath.row].posterPath ?? "")" ?? "/ey2wVKxujc8rYbnGtg8w3DvJpiA.jpg") {
                cell.movieImage.kf.setImage(with: url)
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell =
         collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
        let tabViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        
        self.navigationController?.pushViewController(tabViewController, animated: true)

    }

}
