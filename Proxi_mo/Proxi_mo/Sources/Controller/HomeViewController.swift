//
//  HelloViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.bool(forKey: "tutorialDone") {
            if defaults.string(forKey: "district") != nil && defaults.string(forKey: "county") != nil
                && defaults.string(forKey: "parish") != nil {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "servicesViewController")
                    as! UINavigationController
                let servicesViewController = newViewController.viewControllers.first as! CategoriesViewController
                newViewController.modalPresentationStyle = .fullScreen
                guard let county = defaults.string(forKey: "county") else { return }
                servicesViewController.county = county
                self.present(newViewController, animated: true, completion: nil)
            }
            else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "navigationController")
                    as! UINavigationController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            }
        }
    }
}
