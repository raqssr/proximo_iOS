//
//  HelloViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.bool(forKey: "tutorialDone") {
            guard let _ = defaults.string(forKey: "district"), let county = defaults.string(forKey: "county"),
                let _ = defaults.string(forKey: "parish") else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "navigationController")
                    as! UINavigationController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
                return
            }
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "servicesViewController")
                as! UINavigationController
            let servicesViewController = newViewController.viewControllers.first as! CategoriesViewController
            newViewController.modalPresentationStyle = .fullScreen
            servicesViewController.county = county
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}
