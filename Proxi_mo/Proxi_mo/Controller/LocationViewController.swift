//
//  LocationViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 06/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit
import Squid

class LocationViewController: UIViewController {
    
    @IBOutlet weak var districtName: UILabel!
    @IBOutlet weak var countyName: UILabel!
    @IBOutlet weak var parishName: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var locationCard: UIView!
    @IBOutlet weak var confirmButton: UIView!
    
    let service = ProximoApi()
    let request = BusinessRequest(county: "Carregal do Sal")
    lazy var response: Response<BusinessRequest> = {
        return request.schedule(with: service)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getBusinesses()
    }
    
    func getBusinesses() {
        BusinessesService.shared.fetchBusinesses(response: response)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
