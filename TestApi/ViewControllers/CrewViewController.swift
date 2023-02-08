
import UIKit
import Kingfisher
import Alamofire

class CrewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var people: People?
    var person: Result1?

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(
                UINib(nibName: "CrewTableViewCell", bundle: Bundle.main),
                forCellReuseIdentifier: "CrewTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData1()
    }
    //974169
   func getData1() {
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
        
//        return people?.results?.count ?? 0
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"CrewTableViewCell", for: indexPath) as! CrewTableViewCell
        cell.crewImage.layer.cornerRadius = 20
        cell.crewName.text = people?.results?[indexPath.row].originalName
        
        if ((people?.results?[indexPath.row].adult) != nil) {
            cell.adult.text = "Yes"
        }
        
        else {
            cell.adult.text = "No"
        }
        if (people?.results?[indexPath.row].knownForDepartment == .acting) {
            cell.crewDep.text = "Acting"
        }
        
        else {
            cell.crewDep.text = "Directing"
        }
        
        if let popularity = people?.results?[indexPath.row].popularity {
            cell.popularity.text = "\(popularity)"
        }
            
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w200\(people?.results?[indexPath.row].profilePath ?? "/oTB9vGIBacH5aQNS0pUM74QSWuf.jpg")") {
            cell.crewImage?.kf.setImage(with: url)
        }
        else {
            cell.crewImage?.image = UIImage(named: "default")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(650)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let castVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CastView") as! CastView
        castVC.person = people?.results?[indexPath.row]
        self.navigationController?.pushViewController(castVC, animated: true)
    }

    
   
}
