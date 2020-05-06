//
//  WelcomeViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 05/05/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let tutorialImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "welcome.png"))
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Bem-vindo(a) ao Proxi_mo!"
        title.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        title.textAlignment = .center
        title.font = UIFont(name: "ProximaNova-Bold", size: 26.0)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.text = "O nosso objetivo é facilitar a vida da população, juntando numa única plataforma informação fidedigna atualizada acerca de grandes superfícies ou comércios locais localizados na sua área de residência. Assim, pode evitar perdas de tempo ou saídas de casa desnecessárias, num período em que evitar ajuntamentos de pessoas é essencial."
        description.numberOfLines = 0
        description.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        description.textAlignment = .center
        description.font = UIFont(name: "ProximaNova-Regular", size: 16.0)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        view.addSubview(tutorialImage)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        setupConstraints()
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
    }
}
