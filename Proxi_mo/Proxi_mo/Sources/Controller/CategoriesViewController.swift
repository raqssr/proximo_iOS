//
//  BusinessesTypeViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class CategoriesViewController: UIViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var categories: [String] = []
    var county: String = ""
    
    var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        getCategories()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 156/255, green: 176/255, blue: 245/255,
                                                                        alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = self.county
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-settings"),
                                                                 style: .done, target: self,
                                                                 action: #selector(changeLocationSettings))
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        layout.itemSize = CGSize(width: widthPerItem, height: 60)
        
        categoriesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        categoriesCollectionView.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(categoriesCollectionView)
    }
    
    private func setupConstraints() {
        if #available(iOS 11.0, *) {
            categoriesCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            categoriesCollectionView?.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
        categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getCategories() {
        ProximoNetworking.shared.fetchCategories {
            switch $0 {
            case .success(let cat):
                DispatchQueue.main.async {
                    cat.categories.forEach { c in
                        self.categories.append(c.display)
                    }
                    let sortedCategories = self.categories.sorted { $0.lowercased() < $1.lowercased() }
                    self.categories = sortedCategories
                    self.categoriesCollectionView.reloadData()
                }
            case .failure:
                print("Failed to fetch categories")
            }
        }
    }
    
    @objc func changeLocationSettings() {
        let changeLocationNavVC = UINavigationController(rootViewController: ChangeLocationViewController())
        changeLocationNavVC.modalPresentationStyle = .fullScreen
        let changeLocationVC = changeLocationNavVC.viewControllers.first as! ChangeLocationViewController
        self.navigationController?.pushViewController(changeLocationVC, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier,
                                                      for: indexPath) as! CategoryCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.layer.shadowOffset = CGSize(width: CGFloat(5.0), height: CGFloat(5.0))
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds,
                                             cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.categoryName.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        let companiesNavVC = UINavigationController(rootViewController: CompaniesListViewController())
        companiesNavVC.modalPresentationStyle = .fullScreen
        let companiesVC = companiesNavVC.viewControllers.first as! CompaniesListViewController
        companiesVC.category = category
        companiesVC.county = county
        self.navigationController?.pushViewController(companiesVC, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}
