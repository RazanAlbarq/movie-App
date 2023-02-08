//
//  AppDelegate.swift
//  TestApi
//
//  Created by Razan Barq on 21/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appDelegate = UIApplication.shared.keyWindow

        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        let darkMode = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        if(userLoginStatus)
        {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewVC = mainStoryBoard.instantiateInitialViewController()
            window!.rootViewController = homeViewVC
            //                window!.makeKeyAndVisible()
        }
        else {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Secondry", bundle: nil)
            let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            self.window?.rootViewController = loginVC
//            window!.makeKeyAndVisible()
        }
        if darkMode {
            appDelegate?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set(true, forKey: "darkModeEnabled")
        }
        else {
            appDelegate?.overrideUserInterfaceStyle = .unspecified
            UserDefaults.standard.set(false, forKey: "darkModeEnabled")
        }
        
        return true
    }
    
//    func applicationWillTerminate(_ application: UIApplication) {
//        
//        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//        UserDefaults.standard.synchronize()
//        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
//        window!.rootViewController = loginVC
//        window!.makeKeyAndVisible()
//    }

}

