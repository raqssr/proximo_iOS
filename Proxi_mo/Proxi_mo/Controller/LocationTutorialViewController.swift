//
//  LocationTutorialViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class LocationTutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToHomeScreen(_ sender: Any) {
        print("vou mudar")
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "tutorialDone")
        print(defaults.bool(forKey: "tutorialDone"))
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "initialViewController") as! InitialViewController
        //let oldViewController = storyBoard.instantiateViewController(withIdentifier: "tutorialPageViewController") as! TutorialPageViewController
        self.dismiss(animated: true, completion: nil)
        //self.view.removeFromSuperview()
        //self.view.isHidden = true
        //self.view.
        //self.removeFromParent()
        //self.present(newViewController, animated: true, completion: nil)
        /*let initialViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "initialViewController") as! InitialViewController
        let appDelegate = (self.view.window?.windowScene?.delegate as! SceneDelegate)
        appDelegate.window?.rootViewController = initialViewController*/

    }
}

