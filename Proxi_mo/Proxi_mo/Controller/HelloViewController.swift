//
//  HelloViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "tutorialDone") {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "navigationController") as! UINavigationController
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}
