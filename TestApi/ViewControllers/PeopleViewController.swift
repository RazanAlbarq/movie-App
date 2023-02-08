
import UIKit
import Alamofire
import Kingfisher

class PeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var people: People?
    var person: Result1?
    // 1001865
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(
                UINib(nibName: "FirstCell", bundle: Bundle.main),
                forCellReuseIdentifier: "FirstCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }
    
    
    func getData() {
        AF.request("https://api.themoviedb.org/3/trending/person/week?api_key=c499482730372cb9f5af86970b5a4853", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(People.self, from: data)
                            self.people = resJSON
                            self.tableView.delegate = self
                            self.tableView.dataSource = self
                            self.tableView.reloadData()
                            
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"FirstCell", for: indexPath) as! FirstCell
        cell.personImage.layer.cornerRadius = 20
        cell.personName.text = people?.results?[indexPath.row].name
        
        if people?.results?[indexPath.row].gender == 1 {
            cell.voteAverage.text = "Female"
        }
        
        else {
            cell.voteAverage.text = "Male"
        }
        
        if let popularity = people?.results?[indexPath.row].popularity {
            cell.popularity.text = "\(popularity)"
        }

        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(people?.results?[indexPath.row].profilePath ?? "/oTB9vGIBacH5aQNS0pUM74QSWuf.jpg")") {
            cell.personImage?.kf.setImage(with: url)
            cell.personImage.layer.cornerRadius = 20
        }
        else {
            cell.personImage?.image = UIImage(named: "default")

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(550)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let castVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CastView") as! CastView
        castVC.person = people?.results?[indexPath.row]
        self.navigationController?.pushViewController(castVC, animated: true)
        
    }
}
