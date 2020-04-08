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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        navItem.hidesBackButton = true
        locationCard.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
