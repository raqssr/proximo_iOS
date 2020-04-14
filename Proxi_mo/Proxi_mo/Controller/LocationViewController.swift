//
//  LocationViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 06/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var districtName: UILabel!
    @IBOutlet weak var countyName: UILabel!
    @IBOutlet weak var parishName: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var locationCard: UIView!
    @IBOutlet weak var confirmButton: UIView!
    private var districts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getDistricts()
    }
    
    func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
        navItem.hidesBackButton = true
        locationCard.layer.cornerRadius = 15
        confirmButton.layer.cornerRadius = 10
    }
    
    func getDistricts() {
        ProximoNetworking.shared.fetchAllDistricts { dist in
            switch dist {
            case .success(let dist):
                DispatchQueue.main.async {
                    self.districts = dist.districts
                }
            case .failure:
                print("Failed to fetch districts")
            }
        }
    }
}
