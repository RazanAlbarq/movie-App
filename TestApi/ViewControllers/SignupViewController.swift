//
//  SignupViewController.swift
//  TestApi
//
//  Created by Razan Barq on 07/01/2023.
//

import UIKit
import UIGradient
import Alamofire

class SignupViewController: UIViewController {
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var confirmPassLabel: UILabel!
    @IBOutlet weak var newPassLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmpasswordTextfield: UITextField!
    @IBOutlet weak var gradiantView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    private var backgroundColor: [UIColor] = []
    
    @IBOutlet weak var قثلهسفثقأعففخر: UIButton!
    
    @IBAction func pressRegister(_ sender: UIButton) {
        
        if emailTextfield.text != "" && usernameTextfield.text != "" && passwordTextfield.text != "" && confirmpasswordTextfield.text != "" {
            
            
            guard let email = emailTextfield.text else {return}
            
            guard let username = usernameTextfield.text else {return}
            guard let password = passwordTextfield.text else {return}
            guard let confirmPassword = confirmpasswordTextfield.text else {return}
        }
            else {
                let alert = UIAlertController(title: "", message: "Please fill all the required fields", preferredStyle: .alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel , handler:{
                    action in print("Close")
                })
                alert.addAction(closeAction)
                self.present(alert, animated: true)
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 20
        setBackground()
        signInLabel.text = "Sign in".localize()
        introLabel.text = "Watch on Smart TVs, Playstation, Xbox,Chromecast, Apple Tv, Blu-ray players, and more.".localize()
        watchLabel.text = "Watching at home".localize()
        emailLabel.text = "Email".localize()
        usernameLabel.text = "username".localize()
        newPassLabel.text = "new password".localize()
        confirmPassLabel.text = "Confirm password".localize()
        emailTextfield.placeholder = "Enter your email".localize()
        passwordTextfield.placeholder = "Enter your password".localize()
        confirmpasswordTextfield.placeholder = "Confirm yor password".localize()
        usernameTextfield.placeholder = "Enter your username".localize()
        registerButton.setTitle(  "Register now".localize(), for: .normal)

    }
    
    func setBackground() {
        backgroundColor = [UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.8)
                           , .clear]
        gradiantView.addGradientWithDirection(.bottomToTop, colors: backgroundColor)
    }
}
