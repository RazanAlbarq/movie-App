//
//  AccountViewController.swift
//  TestApi
//
//  Created by Razan Barq on 21/12/2022.
//

import UIKit
import Alamofire
import FADesignable

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: FAImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var sessionDetails: SessionDetails?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSessionDetails()
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
