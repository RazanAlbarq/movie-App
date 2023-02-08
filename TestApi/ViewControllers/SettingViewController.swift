//
//  SettingViewController.swift
//  TestApi
//
//  Created by Razan Barq on 21/12/2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var enButton: UIButton!
    @IBOutlet weak var arButton: UIButton!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var outletSwitch: UISwitch!
    var switchState : Bool?

    
    
    let  colorSwitch = UIColor(red: 0.00, green: 0.71, blue: 0.89, alpha: 1.00)
    
   let btnColor = UIColor(red: 0.05, green: 0.15, blue: 0.25, alpha: 1.00)

    override func viewDidLoad() {
        super.viewDidLoad()
        languageLabel.text = "Change Language".localize()
        englishLabel.text = "English".localize()
        arabicLabel.text = "Arabic".localize()
        modeLabel.text =  "Dark mode".localize()
        checkDarkMode()
        if Locale.current.languageCode == "en" {
            enButton.tintColor = colorSwitch
            arButton.tintColor = UIColor(named: "Color 2")
        }
        else {
            enButton.tintColor = UIColor(named: "Color 2")
            arButton.tintColor = colorSwitch
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    func checkDarkMode() {
        let darkMode = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        if darkMode == true {
            outletSwitch.setOn(true, animated: true)
        }
        else {
            outletSwitch.setOn(false, animated: true)

        }
    }
    

    @IBAction func enButtonPressed(_ sender: Any) {

        UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        exit(0)



    }
    
    @IBAction func clickSwitch(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.keyWindow
        
        if self.outletSwitch.isOn {
            appDelegate?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set(true, forKey: "darkModeEnabled")
            UserDefaults.standard.synchronize()
            return

        }
            appDelegate?.overrideUserInterfaceStyle = .unspecified
            UserDefaults.standard.set(false, forKey: "darkModeEnabled")
            UserDefaults.standard.synchronize()

        return

        
    }
    @IBAction func arButtonPressed(_ sender: Any) {
    
        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        exit(0)


    }

}
