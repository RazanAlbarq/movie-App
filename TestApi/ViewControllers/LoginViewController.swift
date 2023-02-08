

import UIKit
import UIGradient
import Alamofire
import LocalAuthentication
// account id 16014673
class LoginViewController: UIViewController {
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var gradiantView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    private var backgroundColor: [UIColor] = []
    @IBOutlet weak var btnFaceID: UIButton!
    var reqToken: String?
    var token: Token?
    var approveToken: ApproveToken?
    var newSession: NewSession?
    let newSessionID = UserDefaults.standard.string(forKey: "newSessionID")
    let email = UserDefaults.standard
    let password = UserDefaults.standard
    var name: String?
    var userName: String?
    var context = LAContext()
    var err: NSError?
    let localizedReason: String = ""
    
    
    
    @IBAction func perssSignup(_ sender: Any) {
        
        let signupVC = UIStoryboard(name: "Secondry", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(signupVC, animated: true)
    }
    
    @IBAction func pressFaceID(_ sender: Any) {
        
        let localString = "We need to access your face"

        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &err) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,  localizedReason : localString) { (success , error) in

                    if success {
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        let email = UserDefaults.standard.string(forKey: "email")
                        let password = UserDefaults.standard.string(forKey: "password")
                        DispatchQueue.main.async {
                            let homeViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                            let appDelegate = UIApplication.shared.delegate
                            appDelegate?.window??.rootViewController = homeViewVC
                        }
                    }

                }

            }

        else {
            print(err)
        }
        
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        if emailTextfield.text != "" && passwordTextfield.text != "" {
            
            let email = UserDefaults.standard.set( emailTextfield.text , forKey: "email")
            let password = UserDefaults.standard.set(passwordTextfield.text, forKey: "password")
            getToken()
        }
        else {
            let alert = UIAlertController(title: "Please fill all the required fields", message: "", preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel , handler:{
                action in print("Close")
            })
            alert.addAction(closeAction)
            self.present(alert, animated: true)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if ((emailLabel.text != nil)&&(passwordLabel.text != nil)){
            btnFaceID.isHidden = false
        }
        else {
            btnFaceID.isHidden = true
        }
        loginButton.layer.cornerRadius = 20
        signupButton.layer.cornerRadius = 20
        setBackground()
        emailLabel.text = "Email".localize()
        passwordLabel.text = "Password".localize()
        emailTextfield.placeholder =  "Enter your email".localize()
        passwordTextfield.placeholder = "Enter your password".localize()
        loginButton.setTitle("Login".localize(), for: .normal)
        signupButton.setTitle("Signup".localize(), for: .normal)
        signInLabel.text =  "Sign in".localize()
        introLabel.text = "Watch on Smart TVs, Playstation, Xbox,Chromecast, Apple Tv, Blu-ray players, and more.".localize()
        watchLabel.text = "Watching at home".localize()
    }
    
    func setBackground() {
        backgroundColor = [UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.8)
                           , .clear]
        gradiantView.addGradientWithDirection(.bottomToTop, colors: backgroundColor)
    }
    
    func getToken() {
        AF.request("https://api.themoviedb.org/3/authentication/token/new?api_key=c499482730372cb9f5af86970b5a4853", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let data = response.data {
                            let resJSON = try JSONDecoder().decode(Token.self, from: data)
                            self.token = resJSON
                            self.reqToken = self.token?.requestToken
                            self.getApprove()
                            
                        }
                    } catch {
                        print("")
                    }
                case .failure(_):
                    print("")
                }
            })
    }
    
    func getApprove() {
        var parameters: [ String : Any] = ["username" : emailTextfield.text ?? ""
                                           ,"password" : passwordTextfield.text ?? ""
                                           ,"request_token" : reqToken ?? ""]
        
        AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=c499482730372cb9f5af86970b5a4853" , method: .post, parameters: parameters , encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                do {
                    if let data = response.data {
                        let resJSON = try JSONDecoder().decode(ApproveToken.self, from: data)
                        self.approveToken = resJSON
                        if self.approveToken?.success ?? true {
                            self.getSessionID()
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
    
    func getSessionID() {
        var parameters: [ String : Any] = ["request_token" : reqToken ?? ""]
        AF.request("https://api.themoviedb.org/3/authentication/session/new?api_key=c499482730372cb9f5af86970b5a4853" , method: .post, parameters: parameters , encoding: JSONEncoding.default, headers: [:]).responseJSON {
            response in
            switch (response.result) {
            case .success:
                do {
                    if let data = response.data {
                        let resJSON = try JSONDecoder().decode(NewSession.self, from: data)
                        self.newSession = resJSON
                        UserDefaults.standard.set(self.newSession?.sessionID, forKey: "newSessionID")
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        let homeViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = homeViewVC
                        UIView.transition(with:  (appDelegate?.window ?? UIView())!, duration: 0.9, animations: nil)
                        
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
    


