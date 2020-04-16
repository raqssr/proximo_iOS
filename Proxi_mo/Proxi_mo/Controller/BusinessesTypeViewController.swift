//
//  BusinessesTypeViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class BusinessesTypeViewController: UIViewController {
    
    let businesses: [String] = ["Bancos", "Bombas de Combustível", "CTT", "Dentista", "Gás", "Mercados", "Oficinas", "Óticas", "Peixarias", "Restaurantes", "Saúde", "Serviços Administrativos", "Talhos", "Telecomunicações", "Veterinários", "Outros"]
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var categories: [String] = []
    var county: String = ""
    
    @IBOutlet weak var businessesTypeCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        getCategories()
    }
    
    private func setupUI() {
        navigationBar.hidesBackButton = true
        navigationBar.title = self.county
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
    }
    
    private func getCategories() {
        ProximoNetworking.shared.fetchCategories { cat in
            switch cat {
            case .success(let cat):
                DispatchQueue.main.async {
                    self.categories = cat.categories
                    self.businessesTypeCollectionView.reloadData()
                }
            case .failure:
                print("Failed to fetch categories")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            BusinessesListViewController, let index = businessesTypeCollectionView.indexPathsForSelectedItems?.first {
                    destination.category = categories[index.row]
                    destination.county = self.county
                }
    }
}

extension BusinessesTypeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "businessTypeCell", for: indexPath) as! BusinessTypeCell
        cell.layer.cornerRadius = 15
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.businessTypeName.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
}

extension BusinessesTypeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
