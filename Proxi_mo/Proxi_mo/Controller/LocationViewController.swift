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
    private var counties: [String: [[String]]] = [:]
    private var countiesFromDistrict: [[String]] = []
    private var companiesFromDistrict: [String: Business] = [:]
    private var companiesFromGeohash: [String: Business] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        //getDistricts()
        //getCounties()
        //getCountiesFromDistrict(district: "Aveiro")
        //getCompaniesFromDistrict(district: "Aveiro")
        //getCompaniesFromCounty(county: "Aveiro")
        //getCompaniesFromGeohash(geohash: "ez4q1bsmsj7w")
        //getLocation()
        self.districtName.text = "Aveiro"
        self.countyName.text = "Aveiro"
        self.parishName.text = "São Bernardo"
    }
    
    private func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
        navItem.hidesBackButton = true
        locationCard.layer.cornerRadius = 15
        confirmButton.layer.cornerRadius = 10
    }
    
    private func getLocation() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            BusinessesTypeViewController {
            destination.county = self.countyName.text!
        }
    }
    
    private func getDistricts() {
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
    
    private func getCountiesFromDistrict(district: String) {
        ProximoNetworking.shared.fetchCountiesByDistrict(district: district) { count in
            switch count {
            case .success(let count):
                DispatchQueue.main.async {
                    self.countiesFromDistrict = count.counties
                }
            case .failure:
                print("Failed to fetch all counties from \(district)")
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
