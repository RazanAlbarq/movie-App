
import UIKit
import Kingfisher
import Alamofire
import UIGradient
import SideMenu
import FSPagerView

//key -> c499482730372cb9f5af86970b5a4853
// newKey c6780adb140a50ba8b8c93afad4ddc59
//76600
//661374
// let name = UserDefaults.standard.string(forKey: “name”) ?? “”
// UserDefaults.standard.set("Anand", forKey: "name")

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate , MovieDataDelegate {

    
    @IBAction func pressSideMenu(_ sender: Any) {
        if Locale.current.languageCode == "en" {
            present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
        }
        else {
            present(SideMenuManager.default.rightMenuNavigationController!, animated: true, completion: nil)
        }
    }
    
    var arrayMovies: MoviesResponse?
    var nowPlayingArray: MoviesResponse?
    var upComingArray: MoviesResponse?
    let name = UserDefaults.standard
    let userName = UserDefaults.standard
    private var backgroundColor: [UIColor] = []
    let search = UISearchController()


    @IBOutlet weak var sideMenu: UIButton!
    
    @IBOutlet weak var gradiantView: UIView!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.register(
                UINib(nibName: "CustomeCell", bundle: Bundle.main),
                forCellReuseIdentifier: "CustomeCell")
            tableView.register(
                UINib(nibName: "SecondCustomeCell", bundle: Bundle.main),
                forCellReuseIdentifier: "SecondCustomeCell")
            tableView.register(
                UINib(nibName: "ThirdTableViewCell", bundle: Bundle.main),
                forCellReuseIdentifier: "ThirdTableViewCell")
            tableView.register(UINib(nibName: "HeaderView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "HeaderView")
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func pressSearch(_ sender: Any) {
        let search =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(search, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu.tintColor = UIColor(named: "Color 2")
        sideMenuConfigration()
        self.getAllData()
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.title = "Movies".localize()
        self.setBackground()
        DarkMode()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        setBackground()
            }
    
    func DarkMode() {
        let appDelegate = UIApplication.shared.keyWindow
        let darkMode = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        if darkMode == true {
            appDelegate?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set(true, forKey: "darkModeEnabled")

        }
        else {
            appDelegate?.overrideUserInterfaceStyle = .unspecified
            UserDefaults.standard.set(false, forKey: "darkModeEnabled")

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func getData() {
        AF.request("https://api.themoviedb.org/3/movie/popular?api_key=c499482730372cb9f5af86970b5a4853&language=en-US&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            self.arrayMovies = resJSON
                            
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
        AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=c499482730372cb9f5af86970b5a4853&language=en-US&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            self.nowPlayingArray = resJSON
                            
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }
    
    func getData3() {
        AF.request("https://api.themoviedb.org/3/movie/upcoming?api_key=c499482730372cb9f5af86970b5a4853&language=en-US&page=1", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(MoviesResponse.self, from: data)
                            self.upComingArray = resJSON
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
    
    func getAllData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getData()
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        getData3()
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        getData2()
        dispatchGroup.leave()
        
    }
    
    func sideMenuConfigration() {
        // Define the menus
        let menuNavigationController = SideMenuNavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController)
        if Locale.current.languageCode == "en" {
            SideMenuManager.default.rightMenuNavigationController = nil
            SideMenuManager.default.leftMenuNavigationController = menuNavigationController
            SideMenuManager.default.menuFadeStatusBar = false
            
            SideMenuManager.default.leftMenuNavigationController?.menuWidth = 300
            SideMenuManager.default.menuPresentMode = .menuSlideIn
            SideMenuManager.default.menuAnimationFadeStrength = 0.5
        }
        else {
            SideMenuManager.default.leftMenuNavigationController = nil
            SideMenuManager.default.rightMenuNavigationController = menuNavigationController
            SideMenuManager.default.menuFadeStatusBar = false
            
            SideMenuManager.default.rightMenuNavigationController?.menuWidth = 300
            SideMenuManager.default.menuPresentMode = .menuSlideIn
            SideMenuManager.default.menuAnimationFadeStrength = 0.5
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        switch section{
        case 0:
            headerView.headerLabel.text = "POPULAR MOVIES".localize()
        case 1:
            headerView.headerLabel.text = "NOW PLAYING MOVIES".localize()
        case 2:
            headerView.headerLabel.text = "UP COMING MOVIES".localize()
        case 3:
            headerView.headerLabel.text = ""
            
        default:
            headerView.headerLabel.text = "Top Rated".localize()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 =  tableView.dequeueReusableCell(withIdentifier:"CustomeCell", for: indexPath) as! CustomeCell
        
        if indexPath.section == 0   {
            let cell1 =  tableView.dequeueReusableCell(withIdentifier:"CustomeCell", for: indexPath) as! CustomeCell
            cell1.delegate = self
            cell1.setData(response: self.arrayMovies ?? MoviesResponse() )
            return cell1
        }
        else if indexPath.section == 1{
            let cell =  tableView.dequeueReusableCell(withIdentifier:"ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
            cell.delegate = self
            cell.setData(response: self.upComingArray ?? MoviesResponse())
            return cell
        }
        
        else if  indexPath.section == 2 {
            let cell =  tableView.dequeueReusableCell(withIdentifier:"SecondCustomeCell", for: indexPath) as! SecondCustomeCell
            cell.delegate = self
            cell.setData(response: self.nowPlayingArray ?? MoviesResponse())
            return cell
        }
        return UITableViewCell()
    }
    
    
    func selectMovieDelage(movie: Movie) {
        let tabViewControllerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
        tabViewControllerVC.movie = movie
        self.navigationController?.pushViewController(tabViewControllerVC, animated: true)
       
    }
    //  UIColor(red: 0.90, green: 0.89, blue: 1, alpha: 1.00)
    
    func setBackground() {
        backgroundColor = [UIColor(named: "Color 2")!, UIColor(named: "Color 1")!]
        let gradiant = GradientLayer(direction: .bottomToTop, colors: backgroundColor)
        gradiantView.addGradientWithDirection(.bottomToTop, colors: backgroundColor)
    }
    
}

extension String {
    func localize()-> String{
//        let path = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "AppleLanguages") , ofType: "lproj")
//        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName : "Localizable" , bundle: Bundle.main , comment: self)
        
    }
}





