//
//  BusinessesListViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit

final class CompaniesListViewController: UIViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 5.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    private var companiesFromCounty: [String: Company] = [:]
    private var listOfCompanies: [Company] = []
    var category: String = ""
    var county: String = ""
    private var noPicture: Bool = true
    lazy var formatter = DateFormatter()
    lazy var myCalendar = Calendar(identifier: .gregorian)
    
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
        ProximoNetworking.shared.fetchCompaniesByCounty(county: county) {
            switch $0 {
            case .success(let comp):
                DispatchQueue.main.async {
                    comp.companies.forEach { (_, value) in
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
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.businessesListCollectionView.bounds.size.width,
                                                 height: self.businessesListCollectionView.bounds.size.height))
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
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: formatter.string(from: date)) else { return nil }
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return getStringOfWeekDay(weekday: weekDay)
    }
    
    private func getStringOfWeekDay(weekday: Int) -> String {
        switch weekday {
        case 1:
            return "sunday"
        case 2:
            return "monday"
        case 3:
            return "tuesday"
        case 4:
            return "wednesday"
        case 5:
            return "thursday"
        case 6:
            return "friday"
        default:
            return "saturday"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            CompanyDetailViewController, let index = businessesListCollectionView.indexPathsForSelectedItems?.first {
                destination.selectedBusiness = listOfCompanies[index.row]
            }
    }
}

extension CompaniesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listOfCompanies.count == 0 {
            setEmptyMessage()
        }
        else {
            restore()
        }
        
        return listOfCompanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "businessCell", for: indexPath)
            as! CompanyCell
        cell.businessCard.layer.cornerRadius = 10
        cell.businessLogo.layer.borderWidth = 1.0
        cell.businessLogo.layer.masksToBounds = false
        cell.businessLogo.layer.borderColor = UIColor.white.cgColor
        cell.businessLogo.layer.cornerRadius = 20
        cell.businessLogo.clipsToBounds = true
        cell.businessLogo.layer.isOpaque = true
        
        var url = URL(string: "")
        guard let logo = listOfCompanies[indexPath.row].pictures?.logo else {
            print("Failed to fetch logo")
            fatalError()
        }
        
        guard let outside = listOfCompanies[indexPath.row].pictures?.outsidePicture else {
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
            cell.businessLogo.image = UIImage(named: "default_logo")
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
                    cell.businessLogo.image = UIImage(data: dataImage)
                }
            }
        }
        
        cell.businessName.text = listOfCompanies[indexPath.row].name
        let schedule = listOfCompanies[indexPath.row].schedule
        guard let weekday = getDayOfWeek() else { return UICollectionViewCell() }
        switch weekday {
        case "sunday":
            cell.businessSchedule.text = schedule.sunday.joined(separator: ", ")
        case "monday":
            cell.businessSchedule.text = schedule.monday.joined(separator: ", ")
        case "tuesday":
            cell.businessSchedule.text = schedule.tuesday.joined(separator: ", ")
        case "wednesday":
            cell.businessSchedule.text = schedule.wednesday.joined(separator: ", ")
        case "thursday":
            cell.businessSchedule.text = schedule.thursday.joined(separator: ", ")
        case "friday":
            cell.businessSchedule.text = schedule.friday.joined(separator: ", ")
        default:
            cell.businessSchedule.text = schedule.saturday.joined(separator: ", ")
        }
        return cell
    }
}

extension CompaniesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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
