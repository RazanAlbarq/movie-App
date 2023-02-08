//
//  SplashViewController.swift
//  TestApi
//
//  Created by Razan Barq on 11/01/2023.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
   
   
    
    @IBAction func pressLogin(_ sender: Any) {
        let loginVC = UIStoryboard(name: "Secondry", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        //self.present(loginVC, animated: true)
        UIApplication.shared.delegate?.window??.rootViewController = loginVC

    }
    
    @IBAction func pressSignup(_ sender: Any) {
        let signupVC = UIStoryboard(name: "Secondry", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        UIApplication.shared.delegate?.window??.rootViewController = signupVC

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        signupButton.layer.cornerRadius = 20
        loginButton.setTitle("Login".localize(), for: .normal)
        signupButton.setTitle("Signup".localize(), for: .normal)
        
    

    }
    

    
}
