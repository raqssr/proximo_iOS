//
//  ChangeLocationViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 18/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class ChangeLocationViewController: UIViewController {
    
    var districts: [String] = []
    var countiesFromDistrict: [String] = []
    var district: String = ""
    var county: String = ""
    private let defaults = UserDefaults.standard
    
    let changeLocationLabel: UILabel = {
        let display = UILabel()
        display.text = "Altere aqui os campos pretendidos começando pelo distrito:"
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
    
    let districtPicker = UIPickerView()
    let countyPicker = UIPickerView()
    
    let districtName: UITextField = {
        let district = UITextField()
        district.placeholder = "Distrito"
        district.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        district.textAlignment = .left
        district.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        district.borderStyle = UITextField.BorderStyle.roundedRect
        district.translatesAutoresizingMaskIntoConstraints = false
        return district
    }()
    
    let countyName: UITextField = {
        let county = UITextField()
        county.placeholder = "Concelho"
        county.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        county.textAlignment = .left
        county.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        county.borderStyle = UITextField.BorderStyle.roundedRect
        county.translatesAutoresizingMaskIntoConstraints = false
        return county
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

        districtPicker.delegate = self
        countyPicker.delegate = self
        
        setupUI()
        setupConstraints()
        fetchDistrictsToPicker()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 156/255, green: 176/255, blue: 245/255,
                                                                        alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Proxi_mo"
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(changeLocationLabel)
        view.addSubview(locationCard)
        view.addSubview(districtLabel)
        view.addSubview(districtName)
        view.addSubview(countyLabel)
        view.addSubview(countyName)
        view.addSubview(confirmLocationButton)
        
        districtName.inputView = districtPicker
        countyName.inputView = countyPicker
        countyName.isUserInteractionEnabled = false
    }
    
    private func setupConstraints() {
        locationCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationCard.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        locationCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        locationCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        locationCard.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        changeLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        changeLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        changeLocationLabel.bottomAnchor.constraint(equalTo: locationCard.topAnchor, constant: -32).isActive = true
        
        districtLabel.widthAnchor.constraint(equalToConstant: 55).isActive = true
        districtLabel.leadingAnchor.constraint(equalTo: locationCard.leadingAnchor, constant: 32).isActive = true
        districtLabel.topAnchor.constraint(equalTo: locationCard.topAnchor, constant: 32).isActive = true
        
        countyLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        countyLabel.leadingAnchor.constraint(equalTo: locationCard.leadingAnchor, constant: 32).isActive = true
        countyLabel.topAnchor.constraint(equalTo: districtLabel.bottomAnchor, constant: 32).isActive = true
        
        districtName.leadingAnchor.constraint(equalTo: districtLabel.trailingAnchor, constant: 4).isActive = true
        districtName.trailingAnchor.constraint(equalTo: locationCard.trailingAnchor, constant: -32).isActive = true
        districtName.topAnchor.constraint(equalTo: locationCard.topAnchor, constant: 24).isActive = true
        
        countyName.leadingAnchor.constraint(equalTo: countyLabel.trailingAnchor, constant: 4).isActive = true
        countyName.trailingAnchor.constraint(equalTo: locationCard.trailingAnchor, constant: -32).isActive = true
        countyName.topAnchor.constraint(equalTo: districtName.bottomAnchor, constant: 16).isActive = true
        
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
    }
    
    private func fetchDistrictsToPicker() {
        ProximoNetworking.shared.fetchAllDistricts {
            switch $0 {
            case .success(let dist):
                DispatchQueue.main.async {
                    self.districts = dist.districts
                }
            case .failure:
                print("Failed to fetch districts")
            }
        }
    }
    
    private func fetchCountiesToPicker(district: String) {
        ProximoNetworking.shared.fetchCountiesByDistrict(district: district) {
            switch $0 {
            case .success(let count):
                DispatchQueue.main.async {
                    count.counties.forEach { county in
                        guard let c = county.first else { return }
                        self.countiesFromDistrict.append(c)
                    }
                }
            case .failure:
                print("Failed to fetch all counties from \(district)")
            }
        }
    }
    
    @objc private func confirmLocation() {
        if districtName.text != "" && countyName.text != "" {
            self.defaults.set(districtName.text, forKey: "district")
            self.defaults.set(countyName.text, forKey: "county")
            self.defaults.set("Default", forKey: "parish")
            
            let categoriesNavVC = UINavigationController(rootViewController: CategoriesViewController())
            categoriesNavVC.modalPresentationStyle = .fullScreen
            let categoriesVC = categoriesNavVC.viewControllers.first as! CategoriesViewController
            categoriesVC.county = county
            self.navigationController?.pushViewController(categoriesVC, animated: true)
        }
        else {
            displayLocationValidationAlert()
        }
    }
    
    private func displayLocationValidationAlert() {
        let alert = UIAlertController(title: "Alerta",
                                      message: "Deves preencher os dois campos para poderes validar a tua localização.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ChangeLocationViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == districtPicker {
            return districts.count
        }
        else {
            return countiesFromDistrict.count
        }
    }
}

extension ChangeLocationViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == districtPicker {
            return districts[row]
        }
        else {
            return countiesFromDistrict[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == districtPicker {
            countyName.text = ""
            countyName.isUserInteractionEnabled = false
            self.countiesFromDistrict.removeAll()
            district = districts[row]
            districtName.text = district
            fetchCountiesToPicker(district: district)
            countyName.isUserInteractionEnabled = true
            self.view.endEditing(true)
        }
        else {
            county = countiesFromDistrict[row]
            countyName.text = county
            self.view.endEditing(true)
        }
    }
}
