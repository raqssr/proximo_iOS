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
    var category: String = ""
    var county: String = ""
    private var companiesFromCounty: [String: Business] = [:]
    private var listOfCompanies: [Business] = []
    
    @IBOutlet weak var businessesListCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        getCompaniesFromCounty(county: county)
    }
    
    private func setupUI() {
        navigationBar.title = category
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
    }
    
    private func getCompaniesFromCounty(county: String) {
        ProximoNetworking.shared.fetchCompaniesByCounty(county: county) { comp in
            switch comp {
            case .success(let comp):
                DispatchQueue.main.async {
                    for (_, value) in comp.companies {
                        let cat = (self.category.last! == "s") ? String(self.category.dropLast()) : self.category
                        if value.categories.contains(cat) {
                            self.listOfCompanies.append(value)
                        }
                        self.businessesListCollectionView.reloadData()
                    }
                }
            case .failure:
                print("Failed to fetch companies from \(county)")
            }
        }
    }
    
    private func setEmptyMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.businessesListCollectionView.bounds.size.width, height: self.businessesListCollectionView.bounds.size.height))
        messageLabel.text = "Sem empresas para mostrar."
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        messageLabel.sizeToFit()

        self.businessesListCollectionView.backgroundView = messageLabel
    }

    private func restore() {
        self.businessesListCollectionView.backgroundView = nil
    }
    
    private func getDayOfWeek() -> String? {
        let date = Date()
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: formatter.string(from: date)) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return getStringOfWeekDay(weekday: weekDay)
    }
    
    func getStringOfWeekDay(weekday: Int) -> String {
        switch weekday {
        case 0:
            return "sunday"
        case 1:
            return "monday"
        case 2:
            return "tuesday"
        case 3:
            return "wednesday"
        case 4:
            return "thrusday"
        case 5:
            return "friday"
        default:
            return "saturday"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            BusinessDetailViewController, let index = businessesListCollectionView.indexPathsForSelectedItems?.first {
                    destination.selectedBusiness = businessesNames[index.row]
                }
    }
}

extension BusinessesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listOfCompanies.count == 0 {
            setEmptyMessage()
        }
        else {
            restore()
        }
        
        return listOfCompanies.count
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
        cell.businessName.text = listOfCompanies[indexPath.row].name
        cell.businessSchedule.text = listOfCompanies[indexPath.row].schedule.monday.joined(separator: ", ")
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
