//
//  RootViewController.swift
//  TestApi
//
//  Created by Razan Barq on 20/12/2022.
//

import UIKit
import FADesignable
import Alamofire

class LeftMenuViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profileImage: FAImageView!
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var myMoviesLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var searchMoviesLabel: UILabel!
    @IBOutlet weak var user: UIImageView!
    
    @IBOutlet weak var setting: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var mymovies: UIImageView!
    var sessionDetails: SessionDetails?

    @IBOutlet weak var search: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getSessionDetails()
        accountLabel.text = "Account".localize()
        settingsLabel.text = "Setting".localize()
        myMoviesLabel.text = "My Movies".localize()
        searchMoviesLabel.text = "Search Movies".localize()
        logoutLabel.text = "Logout".localize()
        
        if UserDefaults.standard.bool(forKey: "darkModeEnabled") == false {
            user.image = UIImage(named: "user-7")
            setting.image = UIImage(named: "settings-4")
            mymovies.image = UIImage(named: "movie-clapper-open-7")
            search.image = UIImage(named: "search")
        }
            else if UserDefaults.standard.bool(forKey: "darkModeEnabled") == true{
                user.image = UIImage(named: "profile")
                setting.image = UIImage(named: "settings")
                mymovies.image = UIImage(named: "movie-clapper-open-4")
                search.image = UIImage(named: "magnifying-glass")
            }

                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSessionDetails()
        if UserDefaults.standard.bool(forKey: "darkModeEnabled") == false {
            user.image = UIImage(named: "user-7")
            setting.image = UIImage(named: "settings-4")
            mymovies.image = UIImage(named: "movie-clapper-open-7")
            search.image = UIImage(named: "search")
        }
            else if UserDefaults.standard.bool(forKey: "darkModeEnabled") == true{
                user.image = UIImage(named: "profile")
                setting.image = UIImage(named: "settings")
                mymovies.image = UIImage(named: "movie-clapper-open-4")
                search.image = UIImage(named: "magnifying-glass")
            }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 152 : 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let accountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            self.navigationController?.pushViewController(accountVC, animated: true)
           
        case 1:
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let accountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
            self.navigationController?.pushViewController(accountVC, animated: true)

        case 2:
            let settingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            self.navigationController?.pushViewController(settingVC, animated: true)

        case 3:
            let myMoviesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyMoviesViewController") as! MyMoviesViewController
            self.navigationController?.pushViewController(myMoviesVC, animated: true)
        case 4:
            let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            self.navigationController?.pushViewController(searchVC, animated: true)
            
        case 5:
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            nameLabel.text = ""
            usernameLabel.text = ""
            profileImage.image = nil

            let loginVC = UIStoryboard(name: "Secondry", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let appDelegate = UIApplication.shared.delegate
                appDelegate?.window??.rootViewController = loginVC
            
            
            
            
//            let alert = UIAlertController(title: "Are you sure you want to logout?", message: "", preferredStyle: .alert)
//            let closeAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel , handler:{
//                action in
//                let lougoutVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                let appDelegate = UIApplication.shared.delegate
//                appDelegate?.window??.rootViewController = lougoutVC
//
//            })
//            alert.addAction(closeAction)
//            self.present(alert, animated: true)
            
        default:
            let logoutVC = UIStoryboard(name: "Secondry", bundle: nil).instantiateViewController(withIdentifier: "LogoutViewController") as! LogoutViewController
            self.navigationController?.pushViewController(logoutVC, animated: true)
            
        }
    }
    
    func getSessionDetails() {
        if let newSessionID = UserDefaults.standard.string(forKey: "newSessionID") {
            AF.request("https://api.themoviedb.org/3/account?api_key=c499482730372cb9f5af86970b5a4853&session_id=\(newSessionID)", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: [:]).responseJSON {
                response in
                switch (response.result) {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(SessionDetails.self, from: data)
                            self.sessionDetails = resJSON
                            self.nameLabel.text = self.sessionDetails?.name
                            self.usernameLabel.text = self.sessionDetails?.username
                            if let url = URL(string: "https://image.tmdb.org/t/p/w200\(self.sessionDetails?.avatar?.tmdb?.avatarPath ?? "")") {
                                self.profileImage.kf.setImage(with: url)
                            }
                            
                        }
                    } catch {
                        print("")
                    }
                case .failure:
                    print(Error.self)
                }
            }
        }
    }

}
