//
//  MyMoviesViewController.swift
//  TestApi
//
//  Created by Razan Barq on 21/12/2022.
//

import UIKit
import Alamofire
import Kingfisher

class MyMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var favoriteMovies: FavoriteMovies?
    var watchlater: FavoriteMovies?

    
    @IBOutlet weak var collectionViewB: UICollectionView!
    @IBOutlet weak var collectionViewA: UICollectionView!
    
    @IBOutlet weak var watchlistLabel: UILabel!
    
    @IBOutlet weak var favLabel: UILabel!
        
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var watchLaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewA.register(UINib(nibName: "ThirdCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ThirdCollectionViewCell")
        self.collectionViewB.register(UINib(nibName: "ThirdCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ThirdCollectionViewCell")
        favLabel.text =  "Favorite".localize()
        watchlistLabel.text =     "WatchList" .localize()
        getAllData()
        if UserDefaults.standard.bool(forKey: "darkModeEnabled") {
            favButton.setImage(UIImage(named: "like"), for: .normal)
            watchLaterButton.setImage(UIImage(named: "bookmark"), for: .normal)
        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionViewA{
            return 1
        }
        else {
            return 1

        }    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewA{
            return favoriteMovies?.results?.count ?? 0
        }
            return watchlater?.results?.count ?? 0

           }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.bounds.width / 1.7
        let h = collectionView.bounds.width
        return CGSize(width: w, height: h)
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell1 =  collectionView.dequeueReusableCell(withReuseIdentifier:"ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
        
        if collectionView == self.collectionViewA{
            let cellA =
            collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
            cellA.movieLabel.text = favoriteMovies?.results?[indexPath.row].title
            
            if let url = URL(string: "https://image.tmdb.org/t/p/w200\(favoriteMovies?.results?[indexPath.row].posterPath ?? "")") {
                cellA.movieImage?.kf.setImage(with: url)
            }
            return cellA
        }
        
        else {
            let cellB =
            collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as! ThirdCollectionViewCell
            cellB.movieLabel.text = favoriteMovies?.results?[indexPath.row].title
            
            if let url = URL(string: "https://image.tmdb.org/t/p/w200\(favoriteMovies?.results?[indexPath.row].posterPath ?? "")") {
                cellB.movieImage?.kf.setImage(with: url)
            }
            return cellB

        }
    }
    
    func getAllData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getFavorite()
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        getWatchlaterMovies()
        dispatchGroup.leave()
        
        
    }
    
    func getFavorite() {
        let sessionID = UserDefaults.standard.string(forKey: "newSessionID")
        AF.request("https://api.themoviedb.org/3/account/{account_id}/favorite/movies?api_key=c499482730372cb9f5af86970b5a4853&session_id=\(sessionID ?? "" )&sort_by=created_at.asc&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(FavoriteMovies.self, from: data)
                            self.favoriteMovies = resJSON
                                self.collectionViewA.delegate = self
                                self.collectionViewA.dataSource = self
                                self.collectionViewA.reloadData()
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }
//    func getFavorite() {
//        if let sessionID = UserDefaults.standard.string(forKey: "newSessionID") {
//            AF.request("https://api.themoviedb.org/3/account/{account_id}/favorite/movies?api_key=c499482730372cb9f5af86970b5a4853&session_id=\(sessionID)&sort_by=created_at.asc&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
//                .responseJSON(completionHandler: { response in
//                    switch response.result {
//                case .success:
//                    do {
//                        if let data = response.data {
//                            let resJSON = try JSONDecoder().decode(FavoriteMovies.self, from: data)
//                            self.favoriteMovies = resJSON
//                                self.collectionViewA.delegate = self
//                                self.collectionViewA.dataSource = self
//                                self.collectionViewA.reloadData()
//
//                        }
//                    } catch {
//                        print("")
//                    }
//                case .failure:
//                    print(Error.self)
//                }
//            })
//        }
//    }
    
//    func getFavoriteMovies() {
//        if let newSessionID = UserDefaults.standard.string(forKey: "newSessionID") {
//            AF.request("https://api.themoviedb.org/3/account/{account_id}/favorite/movies?api_key=c499482730372cb9f5af86970b5a4853&session_id=\(newSessionID)&sort_by=created_at.asc&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { response in
//            switch (response.result) {
//            case .success:
//                do {
//                    if let data = response.data {
//                        let resJSON = try JSONDecoder().decode(FavoriteMovies.self, from: data)
//                        self.favoriteMovies = resJSON
//                            self.collectionViewA.delegate = self
//                            self.collectionViewA.dataSource = self
//                            self.collectionViewA.reloadData()
//
//
//                    }
//                } catch {
//                    print("")
//                }
//            case .failure(_):
//                print("")
//            }
//        }
//
//        }
//
//    }
    
    func getWatchlaterMovies() {
        if let newSessionID = UserDefaults.standard.string(forKey: "newSessionID") {
            AF.request("https://api.themoviedb.org/3/account/{account_id}/watchlist/movies?api_key=c499482730372cb9f5af86970b5a4853&language=en-US&session_id=\(newSessionID)&sort_by=created_at.asc&page=1", method: .get, encoding: JSONEncoding.default,headers: [:]).responseJSON {
                response in
                    switch (response.result) {
                    case .success:
                        do {
                            if let data = response.data {
                                let resJSON = try JSONDecoder().decode(FavoriteMovies.self, from: data)
                                self.watchlater = resJSON
                                DispatchQueue.main.async {
                                    self.collectionViewB.delegate = self
                                    self.collectionViewB.dataSource = self
                                    self.collectionViewB.reloadData()
                                }
                            }
                        } catch {
                            print("")
                        }
                    case .failure(_):
                       print("")
                    }
                }
        }
    }
    
}
