//
//  SecondCustomeCell.swift
//  TestApi
//
//  Created by Razan Barq on 21/12/2022.
//

import UIKit

class SecondCustomeCell: UITableViewCell , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var arrayMovies: MoviesResponse?
    var movie: Movie?
    var delegate: MovieDataDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            self.collectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SecondCollectionViewCell")
            self.collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setData(response : MoviesResponse){
        self.arrayMovies = response
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return arrayMovies?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.bounds.width / 1.7
        let h = collectionView.bounds.width
        return CGSize(width: w, height: h)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
        
        cell.movieLabel.text = arrayMovies?.movies?[indexPath.row].title
                
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(arrayMovies?.movies?[indexPath.row].posterPath ?? "")") {
            cell.movieImage?.kf.setImage(with: url)
        }
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movie = self.arrayMovies?.movies?[indexPath.row] {
            
            self.delegate?.selectMovieDelage(movie: movie)
        }
    }
 }



