//
//  CustomeCell.swift
//  TestApi
//
//  Created by Razan Barq on 30/11/2022.

import UIKit
import FADesignable
import FSPagerView
import Kingfisher

class CustomeCell: UITableViewCell,FSPagerViewDelegate, FSPagerViewDataSource {
    
   
    @IBOutlet weak var pagerView:FSPagerView!{
        didSet {
        self.pagerView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionViewCell")
        }
        }
    
    
    var arrayMovies: MoviesResponse?
    var movie: Movie?
    var delegate: MovieDataDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.automaticSlidingInterval = 2.0
        self.pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        self.pagerView.decelerationDistance = 6
        self.pagerView.isInfinite = true
        self.pagerView.interitemSpacing = 16
        self.pagerView.itemSize = CGSize(width: 250, height: 300)

    }
    
        func setData(response : MoviesResponse){
            self.arrayMovies = response
            self.pagerView.reloadData()
        }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrayMovies?.movies?.count ?? 0

    }
    
    
    func pagerView(_ pagerView: FSPagerView , cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", at: index) as! CollectionViewCell
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(arrayMovies?.movies?[index].posterPath ?? "")") {
            cell.movieImage?.kf.setImage(with: url)
        }
        cell.movieLabel?.text = arrayMovies?.movies?[index].title
        
            return cell
        
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        if let movie = self.arrayMovies?.movies?[index] {
        self.delegate?.selectMovieDelage(movie: movie)
            
      }
    }
}

protocol MovieDataDelegate {
    func selectMovieDelage(movie: Movie)

}



