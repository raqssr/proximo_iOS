//
//  LocationTutorialViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class LocationTutorialViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    private let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        startButton.layer.cornerRadius = 10
    }
    
    @IBAction func goToHomeScreen(_ sender: Any) {
        defaults.set(true, forKey: "tutorialDone")
        self.dismiss(animated: true, completion: nil)
    }
}

