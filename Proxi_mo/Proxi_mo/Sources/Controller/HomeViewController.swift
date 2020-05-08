//
//  HelloViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "proxi_mo"
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont(name: "ProximaNova-Bold", size: 50.0)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let arrowButton: UIButton = {
        let arrow = UIButton()
        arrow.setImage(UIImage(named: "icon-arrow-left"), for: .normal)
        arrow.addTarget(self, action: #selector(pushTutorialUI), for: .touchUpInside)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.bool(forKey: "tutorialDone") {
            guard let _ = defaults.string(forKey: "district"), let county = defaults.string(forKey: "county"),
                let _ = defaults.string(forKey: "parish") else {
                let getLocationVC = UINavigationController(rootViewController: GetLocationViewController())
                getLocationVC.modalPresentationStyle = .fullScreen
                self.present(getLocationVC, animated: true, completion: nil)
                return
            }
            
            let categoriesNavVC = UINavigationController(rootViewController: CategoriesViewController())
            categoriesNavVC.modalPresentationStyle = .fullScreen
            let categoriesVC = categoriesNavVC.viewControllers.first as! CategoriesViewController
            categoriesVC.county = county
            self.present(categoriesNavVC, animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        view.addSubview(titleLabel)
        view.addSubview(arrowButton)
    }
    
    private func setupConstraints() {
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        arrowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        arrowButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        arrowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
    }
    
    @objc private func pushTutorialUI() {
        let tutorialVC = TutorialPageViewController() as UIPageViewController
        tutorialVC.modalPresentationStyle = .fullScreen
        self.present(tutorialVC, animated: true, completion: nil)
    }
}
