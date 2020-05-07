//
//  LocationTutorialViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class LocationTutorialViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    let tutorialImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "locationPermission.png"))
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Localização"
        title.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        title.textAlignment = .center
        title.font = UIFont(name: "ProximaNova-Bold", size: 26.0)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.text = "De forma a tornar a experiência mais agradável e completa, iremos obter a sua localização automaticamente, se assim o permitir."
        description.numberOfLines = 0
        description.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        description.textAlignment = .center
        description.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    let finishTutorialButton: UIButton = {
        let finish = UIButton()
        finish.setTitle("Começar", for: .normal)
        finish.setTitleColor(.white, for: .normal)
        finish.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        finish.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        finish.titleLabel?.numberOfLines = 0
        finish.layer.cornerRadius = 10
        finish.addTarget(self, action: #selector(tutorialFinished), for: .touchUpInside)
        finish.translatesAutoresizingMaskIntoConstraints = false
        return finish
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(tutorialImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(finishTutorialButton)
    }
    
    private func setupConstraints() {
        tutorialImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tutorialImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tutorialImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tutorialImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -32).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32).isActive = true
        
        finishTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishTutorialButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        finishTutorialButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        finishTutorialButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
    }
    
    @objc private func tutorialFinished() {
        defaults.set(true, forKey: "tutorialDone")
        self.dismiss(animated: true, completion: nil)
    }
}
