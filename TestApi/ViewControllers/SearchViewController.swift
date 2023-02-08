//
//  SearchViewController.swift
//  TestApi
//
//  Created by Razan Barq on 21/12/2022.
//

import UIKit
import Alamofire
import Kingfisher

class SearchViewController: UIViewController  , UITableViewDataSource , UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var searchTextBox: UISearchBar!
    
    var searchResults: MoviesResponse?
    var movie: Movie?
    var searching:Bool?

    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(
                UINib(nibName: "movieCell", bundle: Bundle.main),
                forCellReuseIdentifier: "movieCell")
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchTextBox.tintColor = UIColor(named: "Color 1")
        navigationItem.title = "Search Movies".localize()
        searchTextBox.placeholder = "Search Movies".localize()

    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        self.tableView.reloadData()
    }
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResults = nil
            tableView.reloadData()
            return
        }
        AF.request("https://api.themoviedb.org/3/search/movie?api_key=c499482730372cb9f5af86970b5a4853&query=\(self.searchBar.text ?? "")", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            self.searchResults = resJSON
                            
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
        self.tableView.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! movieCell
    
        cell.movieLabel.text = searchResults?.movies?[indexPath.row].title
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(searchResults?.movies?[indexPath.row].posterPath ?? "")") {
            cell.movieImage?.kf.setImage(with: url)
        }
              
             return cell
         }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        let selectOBJ = searchResults?.movies?[indexPath.row]
        tabVC.movie = selectOBJ
        self.navigationController?.pushViewController(tabVC, animated: true)
    }

}
