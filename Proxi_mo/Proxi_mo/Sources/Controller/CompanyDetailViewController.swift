//
//  BusinessDetailViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class CompanyDetailViewController: UIViewController {
    
    var company: Company?
    private var contacts: [String]? = []
    private var noPicture: Bool = true
    
    let card: UIView = {
        let card = UIView()
        card.backgroundColor = UIColor(red: 241/255, green: 244/255, blue: 250/255, alpha: 1.0)
        card.layer.cornerRadius = 10
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        logo.layer.borderWidth = 1.0
        logo.layer.masksToBounds = false
        logo.layer.borderColor = UIColor.white.cgColor
        logo.layer.cornerRadius = 30
        logo.clipsToBounds = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let name: UILabel = {
        let name = UILabel()
        name.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        name.textAlignment = .left
        name.numberOfLines = 0
        name.font = UIFont(name: "ProximaNova-Bold", size: 17.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let addressLabel: UILabel = {
        let address = UILabel()
        address.text = "Morada:"
        address.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        address.textAlignment = .left
        address.numberOfLines = 0
        address.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        address.translatesAutoresizingMaskIntoConstraints = false
        return address
    }()
    
    let addressText: UILabel = {
        let address = UILabel()
        address.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        address.textAlignment = .left
        address.numberOfLines = 0
        address.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        address.translatesAutoresizingMaskIntoConstraints = false
        return address
    }()
    
    let phoneLabel: UILabel = {
        let phone = UILabel()
        phone.text = "Contacto:"
        phone.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        phone.textAlignment = .left
        phone.numberOfLines = 0
        phone.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        phone.translatesAutoresizingMaskIntoConstraints = false
        return phone
    }()
    
    let phoneText: UILabel = {
        let phone = UILabel()
        phone.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        phone.textAlignment = .left
        phone.numberOfLines = 0
        phone.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        phone.translatesAutoresizingMaskIntoConstraints = false
        return phone
    }()
    
    let deliveryLabel: UILabel = {
        let delivery = UILabel()
        delivery.text = "Entregas ao domicílio:"
        delivery.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        delivery.textAlignment = .left
        delivery.numberOfLines = 0
        delivery.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        delivery.translatesAutoresizingMaskIntoConstraints = false
        return delivery
    }()
    
    let deliveryText: UILabel = {
        let delivery = UILabel()
        delivery.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        delivery.textAlignment = .left
        delivery.numberOfLines = 0
        delivery.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        delivery.translatesAutoresizingMaskIntoConstraints = false
        return delivery
    }()
    
    let informationLabel: UILabel = {
        let information = UILabel()
        information.text = "Notas:"
        information.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        information.textAlignment = .left
        information.numberOfLines = 0
        information.font = UIFont(name: "ProximaNova-Bold", size: 15.0)
        information.translatesAutoresizingMaskIntoConstraints = false
        return information
    }()
    
    let informationText: UILabel = {
        let information = UILabel()
        information.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        information.textAlignment = .left
        information.numberOfLines = 0
        information.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        information.translatesAutoresizingMaskIntoConstraints = false
        return information
    }()
    
    let locationButton: UIButton = {
        let location = UIButton()
        location.setImage(UIImage(named: "icon-location"), for: .normal)
        location.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    let facebookButton: UIButton = {
        let facebook = UIButton()
        facebook.setImage(UIImage(named: "icon-facebook"), for: .normal)
        facebook.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
        facebook.translatesAutoresizingMaskIntoConstraints = false
        return facebook
    }()
    
    let instagramButton: UIButton = {
        let instagram = UIButton()
        instagram.setImage(UIImage(named: "icon-instagram"), for: .normal)
        instagram.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        instagram.translatesAutoresizingMaskIntoConstraints = false
        return instagram
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupConstraints()
        displayDataInUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 156/255, green: 176/255, blue: 245/255,
                                                                        alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = company?.name
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        view.addSubview(card)
        view.addSubview(logo)
        view.addSubview(name)
        view.addSubview(addressLabel)
        view.addSubview(addressText)
        view.addSubview(phoneLabel)
        view.addSubview(phoneText)
        view.addSubview(deliveryLabel)
        view.addSubview(deliveryText)
        view.addSubview(informationLabel)
        view.addSubview(informationText)
        view.addSubview(locationButton)
        view.addSubview(instagramButton)
        view.addSubview(facebookButton)
    }
    
    private func setupConstraints() {
        card.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        card.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        
        logo.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 70).isActive = true
        logo.topAnchor.constraint(equalTo: card.topAnchor, constant: 16).isActive = true
        
        name.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 24).isActive = true
        name.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: 16).isActive = true
        
        addressLabel.widthAnchor.constraint(equalToConstant: 61).isActive = true
        addressLabel.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 32).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        
        addressText.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 4).isActive = true
        addressText.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 32).isActive = true
        addressText.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16).isActive = true
        
        phoneLabel.widthAnchor.constraint(equalToConstant: 67).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: addressText.bottomAnchor, constant: 32).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        
        phoneText.leadingAnchor.constraint(equalTo: phoneLabel.trailingAnchor, constant: 4).isActive = true
        phoneText.topAnchor.constraint(equalTo: addressText.bottomAnchor, constant: 32).isActive = true
        phoneText.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16).isActive = true
        
        deliveryLabel.widthAnchor.constraint(equalToConstant: 155).isActive = true
        deliveryLabel.topAnchor.constraint(equalTo: phoneText.bottomAnchor, constant: 32).isActive = true
        deliveryLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        
        deliveryText.leadingAnchor.constraint(equalTo: deliveryLabel.trailingAnchor, constant: 4).isActive = true
        deliveryText.topAnchor.constraint(equalTo: phoneText.bottomAnchor, constant: 32).isActive = true
        deliveryText.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16).isActive = true
        
        informationLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        informationLabel.topAnchor.constraint(equalTo: deliveryText.bottomAnchor, constant: 32).isActive = true
        informationLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16).isActive = true
        
        informationText.leadingAnchor.constraint(equalTo: informationLabel.trailingAnchor, constant: 4).isActive = true
        informationText.topAnchor.constraint(equalTo: deliveryText.bottomAnchor, constant: 32).isActive = true
        informationText.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16).isActive = true
        
        facebookButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
        facebookButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16).isActive = true
        
        locationButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: facebookButton.leadingAnchor, constant: -24).isActive = true
        locationButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16).isActive = true
        
        instagramButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        instagramButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        instagramButton.leadingAnchor.constraint(equalTo: facebookButton.trailingAnchor, constant: 24).isActive = true
        instagramButton.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16).isActive = true
    }
    
    private func displayDataInUI() {
        var url = URL(string: "")
        guard let logo = company?.pictures?.logo else {
            print("Failed to fetch logo")
            fatalError()
        }
        
        guard let outside = company?.pictures?.outsidePicture else {
            print("Failed to fetch outside picture")
            fatalError()
        }
        
        if logo != "" {
            url = URL(string: logo)
            noPicture = false
        }
        else if outside != "" {
            url = URL(string: outside)
            noPicture = false
        }
        else {
            self.logo.image = UIImage(named: "default_logo")
        }
        
        if !noPicture {
            DispatchQueue.global().async {
                guard let urlImage = url else {
                    print("Error fecthing url of image")
                    return
                }
                let data = try? Data(contentsOf: urlImage)
                DispatchQueue.main.async {
                    guard let dataImage = data else {
                        print("Error fetching data from url")
                        return
                    }
                    self.logo.image = UIImage(data: dataImage)
                }
            }
        }
        
        name.text = company?.name
        addressText.text = company?.address
        contacts = (company?.contacts.mobile ?? []) + (company?.contacts.phone ?? [])
        phoneText.text = contacts?.filter({ $0 != "" }).joined(separator: ", ")
                
        guard let delivery = company?.delivery else {
            print("Failed to unwrap delivery information")
            deliveryText.text = "Sem informação"
            return
        }
        
        if delivery {
            deliveryText.text = "Sim"
        }
        else {
            deliveryText.text = "Não"
        }
        
        guard let notes = company?.notes else {
            print("Failed to unwrap notes information")
            return
        }
        
        if notes != "" {
            informationText.text = (company?.notes)!
        }
        else {
            informationText.text = "Sem informação"
        }
        
        guard let facebook = company?.socialNetworks?.facebook else {
            print("Failed to unwrap facebook information")
            return
        }
        
        if facebook == "" {
            facebookButton.isEnabled = false
        }
        
        guard let instagram = company?.socialNetworks?.instagram else {
            print("Failed to unwrap instagram information")
            return
        }
        
        if instagram == "" {
            instagramButton.isEnabled = false
        }
    }
    
    @objc private func openMap() {
        guard let url = URL(string: (company?.gmapsUrl)!) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func openFacebook() {
        guard let url = URL(string: (company?.socialNetworks?.facebook)!) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc private func openInstagram() {
        guard let url = URL(string: (company?.socialNetworks?.instagram)!) else { return }
        UIApplication.shared.open(url)
    }
}
