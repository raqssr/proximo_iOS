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
    
    private var districts: [String] = []
    private var counties: [String: [[String]]] = [:]
    private var countiesFromDistrict: [[String]] = []
    private var companiesFromDistrict: [String: Company] = [:]
    private var companiesFromGeohash: [String: Company] = [:]
    var district: String = ""
    var county: String = ""
    var parish: String = ""
    
    let displayLocationLabel: UILabel = {
        let display = UILabel()
        display.text = "Foi detetado que se encontra na seguinte localização. Por favor confirme ou altere os campos apresentados."
        display.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        display.textAlignment = .center
        display.numberOfLines = 0
        display.font = UIFont(name: "ProximaNova-Regular", size: 17.0)
        display.translatesAutoresizingMaskIntoConstraints = false
        return display
    }()
    
    let locationCard: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        card.layer.cornerRadius = 15
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    let districtLabel: UILabel = {
        let district = UILabel()
        district.text = "Distrito:"
        district.textColor = .white
        district.textAlignment = .center
        district.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        district.translatesAutoresizingMaskIntoConstraints = false
        return district
    }()
    
    let countyLabel: UILabel = {
        let county = UILabel()
        county.text = "Concelho:"
        county.textColor = .white
        county.textAlignment = .center
        county.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        county.translatesAutoresizingMaskIntoConstraints = false
        return county
    }()
    
    let parishLabel: UILabel = {
        let parish = UILabel()
        parish.text = "Freguesia:"
        parish.textColor = .white
        parish.textAlignment = .center
        parish.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        parish.translatesAutoresizingMaskIntoConstraints = false
        return parish
    }()
    
    let districtName: UILabel = {
        let district = UILabel()
        district.textColor = .white
        district.textAlignment = .left
        district.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        district.translatesAutoresizingMaskIntoConstraints = false
        return district
    }()
    
    let countyName: UILabel = {
        let county = UILabel()
        county.textColor = .white
        county.textAlignment = .left
        county.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        county.translatesAutoresizingMaskIntoConstraints = false
        return county
    }()
    
    let parishName: UILabel = {
        let parish = UILabel()
        parish.textColor = .white
        parish.textAlignment = .left
        parish.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        parish.translatesAutoresizingMaskIntoConstraints = false
        return parish
    }()
    
    let changeLocationButton: UIButton = {
        let change = UIButton()
        change.setTitle("Alterar", for: .normal)
        change.setTitleColor(.white, for: .normal)
        change.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        change.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        change.titleLabel?.numberOfLines = 0
        change.layer.cornerRadius = 10
        change.addTarget(self, action: #selector(changeLocation), for: .touchUpInside)
        change.translatesAutoresizingMaskIntoConstraints = false
        return change
    }()
    
    let confirmLocationButton: UIButton = {
        let confirm = UIButton()
        confirm.setTitle("Confirmar", for: .normal)
        confirm.setTitleColor(.white, for: .normal)
        confirm.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        confirm.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        confirm.titleLabel?.numberOfLines = 0
        confirm.layer.cornerRadius = 10
        confirm.addTarget(self, action: #selector(confirmLocation), for: .touchUpInside)
        confirm.translatesAutoresizingMaskIntoConstraints = false
        return confirm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        //getCounties()
        //getCompaniesFromDistrict(district: "Aveiro")
        //getCompaniesFromCounty(county: "Aveiro")
        //getCompaniesFromGeohash(geohash: "ez4q1bsmsj7w")
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 156/255, green: 176/255, blue: 245/255,
                                                                        alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Proxi_mo"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.districtName.text = district
        self.countyName.text = county
        self.parishName.text = parish
        
        view.addSubview(displayLocationLabel)
        view.addSubview(locationCard)
        view.addSubview(districtLabel)
        view.addSubview(countyLabel)
        view.addSubview(parishLabel)
        view.addSubview(districtName)
        view.addSubview(countyName)
        view.addSubview(parishName)
        view.addSubview(confirmLocationButton)
        view.addSubview(changeLocationButton)
    }
    
    private func setupConstraints() {
        locationCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationCard.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        locationCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        locationCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        locationCard.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        displayLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        displayLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        displayLocationLabel.bottomAnchor.constraint(equalTo: locationCard.topAnchor, constant: -32).isActive = true
        
        districtLabel.widthAnchor.constraint(equalToConstant: 55).isActive = true
        districtLabel.leadingAnchor.constraint(equalTo: locationCard.leadingAnchor, constant: 32).isActive = true
        districtLabel.topAnchor.constraint(equalTo: locationCard.topAnchor, constant: 32).isActive = true
        
        countyLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        countyLabel.leadingAnchor.constraint(equalTo: locationCard.leadingAnchor, constant: 32).isActive = true
        countyLabel.topAnchor.constraint(equalTo: districtLabel.bottomAnchor, constant: 16).isActive = true
        
        parishLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
        parishLabel.leadingAnchor.constraint(equalTo: locationCard.leadingAnchor, constant: 32).isActive = true
        parishLabel.topAnchor.constraint(equalTo: countyLabel.bottomAnchor, constant: 16).isActive = true
        
        districtName.topAnchor.constraint(equalTo: locationCard.topAnchor, constant: 32).isActive = true
        districtName.leadingAnchor.constraint(equalTo: districtLabel.trailingAnchor, constant: 4).isActive = true
        districtName.trailingAnchor.constraint(greaterThanOrEqualTo: locationCard.trailingAnchor,
                                               constant: -32).isActive = true
        
        countyName.topAnchor.constraint(equalTo: districtName.bottomAnchor, constant: 16).isActive = true
        countyName.leadingAnchor.constraint(equalTo: countyLabel.trailingAnchor, constant: 4).isActive = true
        countyName.trailingAnchor.constraint(equalTo: locationCard.trailingAnchor, constant: -32).isActive = true
        
        parishName.topAnchor.constraint(equalTo: countyName.bottomAnchor, constant: 16).isActive = true
        parishName.leadingAnchor.constraint(equalTo: parishLabel.trailingAnchor, constant: 4).isActive = true
        parishName.trailingAnchor.constraint(equalTo: locationCard.trailingAnchor, constant: -32).isActive = true
        
        confirmLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmLocationButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        confirmLocationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        if #available(iOS 11.0, *) {
            confirmLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                          constant: -16).isActive = true
        } else {
            confirmLocationButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor,
                                                          constant: -16).isActive = true
        }
        
        changeLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeLocationButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        changeLocationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeLocationButton.bottomAnchor.constraint(equalTo: confirmLocationButton.topAnchor,
                                                     constant: -8).isActive = true
    }
    
    @objc private func confirmLocation() {
        let categoriesNavVC = UINavigationController(rootViewController: CategoriesViewController())
        categoriesNavVC.modalPresentationStyle = .fullScreen
        let categoriesVC = categoriesNavVC.viewControllers.first as! CategoriesViewController
        categoriesVC.county = county
        self.navigationController?.pushViewController(categoriesVC, animated: true)
    }
    
    @objc private func changeLocation() {
        let changeLocationNavVC = UINavigationController(rootViewController: ChangeLocationViewController())
        changeLocationNavVC.modalPresentationStyle = .fullScreen
        let changeLocationVC = changeLocationNavVC.viewControllers.first as! ChangeLocationViewController
        self.navigationController?.pushViewController(changeLocationVC, animated: true)
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
