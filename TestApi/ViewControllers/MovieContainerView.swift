
import UIKit
import Tabman
import Pageboy


class MovieContainerView: TabmanViewController , PageboyViewControllerDataSource, TMBarDataSource{
    
    private var viewControllers : [UIViewController] = []
    var movie: Movie?

    
    var butttonColor = UIColor(red: 0.05, green: 0.15, blue: 0.25, alpha: 1.00)
    var selectedButton = UIColor(red: 0.00, green: 0.71, blue: 0.89, alpha: 1.00)



    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieView") as! MovieView
        
            first.movie = self.movie
        
            let second = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CrewViewController") as! CrewViewController
            
        let third = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PeopleViewController") as! PeopleViewController
        
        
 viewControllers = [first , second , third]
      
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.delegate = self
        bar.dataSource = self
        bar.backgroundColor = UIColor(named: "Color 1")
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .snap
        addBar(bar, dataSource: self, at: .top)
        bar.buttons.customize{ (button) in
            button.tintColor = UIColor(red: 0.05, green: 0.15, blue: 0.25, alpha: 1.00)
            button.selectedTintColor = UIColor(red: 0.00, green: 0.71, blue: 0.89, alpha: 1.00)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        self.viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return self.viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title: "Overview".localize())
        case 1:
            return TMBarItem(title: "Trending".localize())
        case 2:
            return TMBarItem(title: "Poupular".localize())
        default:
            return TMBarItem(title: "Poupular".localize())

        }
        
    }
    
}
