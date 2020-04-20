//
//  LocationViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 06/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit
import CoreLocation

final class DisplayLocationViewController: UIViewController {
    
    @IBOutlet weak var districtName: UILabel!
    @IBOutlet weak var countyName: UILabel!
    @IBOutlet weak var parishName: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var locationCard: UIView!
    @IBOutlet weak var confirmButton: UIView!
    @IBOutlet weak var changeButton: UIButton!
    
    private var districts: [String] = []
    private var counties: [String: [[String]]] = [:]
    private var countiesFromDistrict: [[String]] = []
    private var companiesFromDistrict: [String: Company] = [:]
    private var companiesFromGeohash: [String: Company] = [:]
    var district: String = ""
    var county: String = ""
    var parish: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        //getCounties()
        //getCompaniesFromDistrict(district: "Aveiro")
        //getCompaniesFromCounty(county: "Aveiro")
        //getCompaniesFromGeohash(geohash: "ez4q1bsmsj7w")
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
        navItem.hidesBackButton = true
        locationCard.layer.cornerRadius = 15
        confirmButton.layer.cornerRadius = 10
        changeButton.layer.cornerRadius = 10
        self.districtName.text = district
        self.countyName.text = county
        self.parishName.text = parish
    }
    
    @IBAction func confirmLocation(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "servicesViewController")
            as! UINavigationController
        let servicesViewController = newViewController.viewControllers.first as! CategoriesViewController
        newViewController.modalPresentationStyle = .fullScreen
        servicesViewController.county = county
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func changeLocation(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "changeLocationViewController")
            as! UINavigationController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func getCounties() {
        ProximoNetworking.shared.fetchAllCounties { count in
            switch count {
            case .success(let count):
                DispatchQueue.main.async {
                    self.counties = count.counties
                }
            case .failure:
                print("Failed to fetch all the counties")
            }
        }
    }
    
    private func getCompaniesFromDistrict(district: String) {
        ProximoNetworking.shared.fetchCompaniesByDistrict(district: district) { comp in
            switch comp {
            case .success(let comp):
                DispatchQueue.main.async {
                    self.companiesFromDistrict = comp.companies
                }
            case .failure:
                print("Failed to fetch companies from \(district)")
            }
        }
    }
    
    private func getCompaniesFromGeohash(geohash: String) {
        ProximoNetworking.shared.fetchCompaniesByGeohash(geohash: geohash) { comp in
            switch comp {
            case .success(let comp):
                DispatchQueue.main.async {
                    self.companiesFromGeohash = comp.companies
                }
            case .failure:
                print("Failed to fetch companies from geohash \(geohash)")
            }
        }
    }
}
