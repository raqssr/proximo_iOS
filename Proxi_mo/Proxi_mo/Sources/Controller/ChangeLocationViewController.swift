//
//  ChangeLocationViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 18/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
final class ChangeLocationViewController: UIViewController {
    
    @IBOutlet weak var locationCard: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var countyTextField: UITextField!
    
    var districts: [String] = []
    var countiesFromDistrict: [String] = []
    let districtPicker = UIPickerView()
    let countyPicker = UIPickerView()
    var district: String = ""
    var county: String = ""
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        districtPicker.delegate = self
        countyPicker.delegate = self
        
        setupUI()
        createPickers()
        fetchDistrictsToPicker()
    }
    
    @available(iOS 13.0, *)
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
        navItem.hidesBackButton = true
        locationCard.layer.cornerRadius = 15
        confirmButton.layer.cornerRadius = 10
        countyTextField.isUserInteractionEnabled = false
    }
    
    private func createPickers() {
        districtTextField.inputView = districtPicker
        countyTextField.inputView = countyPicker
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
    
    @IBAction func confirmLocation(_ sender: Any) {
        if districtTextField.text != "" && countyTextField.text != "" {
            self.defaults.set(districtTextField.text, forKey: "district")
            self.defaults.set(countyTextField.text, forKey: "county")
            self.defaults.set("Default", forKey: "parish")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "servicesViewController")
                as! UINavigationController
            let servicesViewController = newViewController.viewControllers.first as! CategoriesViewController
            newViewController.modalPresentationStyle = .fullScreen
            servicesViewController.county = countyTextField.text!
            self.present(newViewController, animated: true, completion: nil)
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

@available(iOS 13.0, *)
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

@available(iOS 13.0, *)
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
            countyTextField.text = ""
            countyTextField.isUserInteractionEnabled = false
            self.countiesFromDistrict.removeAll()
            district = districts[row]
            districtTextField.text = district
            fetchCountiesToPicker(district: district)
            countyTextField.isUserInteractionEnabled = true
            self.view.endEditing(true)
        }
        else {
            county = countiesFromDistrict[row]
            countyTextField.text = county
            self.view.endEditing(true)
        }
    }
}
