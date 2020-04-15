//
//  BusinessesListViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

class BusinessesListViewController: UIViewController {
    
    let businessesNames: [String] = ["Mercado 1", "Mercado 2", "Mercado Manuel Firmino"]
    let businessesSchedules: [String] = ["08h30 - 19h30", "15h20 - 20h45", "10h30 - 15h30"]
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 5.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    @IBOutlet weak var businessesListCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
    }
}

extension BusinessesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return businessesNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "businessCell", for: indexPath) as! BusinessCell
        cell.businessCard.layer.cornerRadius = 10
        cell.businessLogo.layer.borderWidth = 1.0
        cell.businessLogo.layer.masksToBounds = false
        cell.businessLogo.layer.borderColor = UIColor.white.cgColor
        cell.businessLogo.layer.cornerRadius = 20
        cell.businessLogo.clipsToBounds = true
        let url = URL(string: "https://plasticoresponsavel.continente.pt/wp-content/uploads/2019/04/IMG_8383.jpg")
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
                cell.businessLogo.image = UIImage(data: dataImage)
            }
        }
        cell.businessName.text = businessesNames[indexPath.row]
        cell.businessSchedule.text = businessesSchedules[indexPath.row]
        return cell
    }
}

extension BusinessesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 200)
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
