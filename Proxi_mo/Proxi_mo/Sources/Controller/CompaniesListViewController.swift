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
    
    var companiesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        getCompaniesFromCounty(county: county)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 156/255, green: 176/255, blue: 245/255,
                                                                        alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = category
        self.navigationController?.navigationBar.isTranslucent = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        layout.itemSize = CGSize(width: widthPerItem, height: 60)
        
        companiesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        companiesCollectionView.register(CompanyCell.self, forCellWithReuseIdentifier: CompanyCell.identifier)
        companiesCollectionView.backgroundColor = .white
        companiesCollectionView.dataSource = self
        companiesCollectionView.delegate = self
        companiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(companiesCollectionView)
    }
    
    private func setupConstraints() {
        if #available(iOS 11.0, *) {
            companiesCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            companiesCollectionView?.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
        companiesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        companiesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        companiesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
                        self.companiesCollectionView.reloadData()
                    }
                }
            case .failure:
                print("Failed to fetch companies from \(county)")
            }
        }
    }
    
    private func setEmptyMessage() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.companiesCollectionView.bounds.size.width,
                                              height: self.companiesCollectionView.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.text = "Sem empresas para mostrar."
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let addCompaniesButton = UIButton(frame: CGRect(x: 0, y: 0, width: 140, height: 40))
        addCompaniesButton.setTitle("Contribua para a nossa plataforma!", for: .normal)
        addCompaniesButton.setTitleColor(.white, for: .normal)
        addCompaniesButton.backgroundColor = UIColor(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        addCompaniesButton.titleLabel?.font = UIFont(name: "ProximaNova-Regular", size: 15.0)
        addCompaniesButton.titleLabel?.numberOfLines = 0
        addCompaniesButton.layer.cornerRadius = 10
        addCompaniesButton.addTarget(self, action: #selector(openForm), for: .touchUpInside)
        addCompaniesButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.companiesCollectionView.addSubview(customView)
        customView.addSubview(messageLabel)
        customView.addSubview(addCompaniesButton)
        
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        addCompaniesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addCompaniesButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24).isActive = true
        addCompaniesButton.leadingAnchor.constraint(equalTo: companiesCollectionView.leadingAnchor,
                                                    constant: 32).isActive = true
        addCompaniesButton.trailingAnchor.constraint(equalTo: companiesCollectionView.trailingAnchor,
                                                     constant: 32).isActive = true
        addCompaniesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        self.companiesCollectionView.backgroundView = customView
    }
    
    @objc private func openForm() {
        if let url = URL(string: "https://form.proxi-mo.pt/") {
            UIApplication.shared.open(url)
        }
    }

    private func restore() {
        self.companiesCollectionView.backgroundView = nil
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath)
                as! CompanyCell
        
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
            cell.companyLogo.image = UIImage(named: "default_logo")
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
                    cell.companyLogo.image = UIImage(data: dataImage)
                }
            }
        }
        
        cell.companyName.text = listOfCompanies[indexPath.row].name
        let schedule = listOfCompanies[indexPath.row].schedule
        guard let weekday = getDayOfWeek() else { return UICollectionViewCell() }
        switch weekday {
        case "sunday":
            cell.companySchedule.text = schedule.sunday.joined(separator: ", ")
        case "monday":
            cell.companySchedule.text = schedule.monday.joined(separator: ", ")
        case "tuesday":
            cell.companySchedule.text = schedule.tuesday.joined(separator: ", ")
        case "wednesday":
            cell.companySchedule.text = schedule.wednesday.joined(separator: ", ")
        case "thursday":
            cell.companySchedule.text = schedule.thursday.joined(separator: ", ")
        case "friday":
            cell.companySchedule.text = schedule.friday.joined(separator: ", ")
        default:
            cell.companySchedule.text = schedule.saturday.joined(separator: ", ")
        }
            
        return cell
    }
}

extension CompaniesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let company = listOfCompanies[indexPath.row]
        let companyDetailsNavVC = UINavigationController(rootViewController: CompanyDetailViewController())
        companyDetailsNavVC.modalPresentationStyle = .fullScreen
        let companyDetailsVC = companyDetailsNavVC.viewControllers.first as! CompanyDetailViewController
        companyDetailsVC.company = company
        self.navigationController?.pushViewController(companyDetailsVC, animated: true)
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
