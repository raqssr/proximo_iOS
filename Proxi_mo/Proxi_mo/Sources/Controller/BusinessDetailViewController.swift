//
//  BusinessDetailViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 08/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailViewController: UIViewController {
    
    @IBOutlet weak var businessCard: UIView!
    @IBOutlet weak var businessLogo: UIImageView!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var businessAddress: UILabel!
    @IBOutlet weak var businessPhone: UILabel!
    @IBOutlet weak var businessDelivery: UILabel!
    @IBOutlet weak var businessInfo: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    
    var selectedBusiness: Business?
    private var contacts: [String]? = []
    private var noPicture: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        displayDataInUI()
    }
    
    private func setupUI() {
        navigationBar.title = selectedBusiness?.name
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
        businessCard.layer.cornerRadius = 10
        businessLogo.layer.borderWidth = 1.0
        businessLogo.layer.masksToBounds = false
        businessLogo.layer.borderColor = UIColor.white.cgColor
        businessLogo.layer.cornerRadius = 20
        businessLogo.clipsToBounds = true
    }
    
    private func displayDataInUI() {
        var url = URL(string: "")
        guard let logo = selectedBusiness?.pictures?.logo else {
            print("Failed to fetch logo")
            fatalError()
        }
        
        guard let outside = selectedBusiness?.pictures?.outsidePicture else {
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
            self.businessLogo.image = UIImage(named: "default_logo")
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
                    self.businessLogo.image = UIImage(data: dataImage)
                }
            }
        }
        
        businessName.text = selectedBusiness?.name
        businessAddress.text = selectedBusiness?.address
        contacts = (selectedBusiness?.contacts.mobile ?? []) + (selectedBusiness?.contacts.phone ?? [])
        businessPhone.text = contacts?.filter({ $0 != "" }).joined(separator: ", ")
                
        guard let delivery = selectedBusiness?.delivery else {
            print("Failed to unwrap delivery information")
            businessDelivery.text = "Sem informação"
            return
        }
        
        if delivery {
            businessDelivery.text = "Sim"
        }
        else {
            businessDelivery.text = "Não"
        }
        
        guard let notes = selectedBusiness?.notes else {
            print("Failed to unwrap notes information")
            return
        }
        
        if notes != "" {
            businessInfo.text = (selectedBusiness?.notes)!
        }
        else {
            businessInfo.text = "Sem informação"
        }
        
        guard let facebook = selectedBusiness?.socialNetworks?.facebook else {
            print("Failed to unwrap facebook information")
            return
        }
        
        if facebook == "" {
            facebookButton.isEnabled = false
        }
        
        guard let instagram = selectedBusiness?.socialNetworks?.instagram else {
            print("Failed to unwrap instagram information")
            return
        }
        
        if instagram == "" {
            instagramButton.isEnabled = false
        }
    }
    
    @IBAction func openMap(_ sender: Any) {
        openMapForPlace(lat: (selectedBusiness?.lat)!, long: (selectedBusiness?.long)!)
    }
    
    private func openMapForPlace(lat: Double, long: Double) {

        let regionDistance:CLLocationDistance = 50
        let coordinates = CLLocationCoordinate2DMake(lat, long)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = selectedBusiness?.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func openFacebook(_ sender: Any) {
        guard let url = URL(string: (selectedBusiness?.socialNetworks?.facebook)!) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func openInstagram(_ sender: Any) {
        guard let url = URL(string: (selectedBusiness?.socialNetworks?.instagram)!) else { return }
        UIApplication.shared.open(url)
    }
    
    
}
