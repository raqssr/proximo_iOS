//
//  InitialViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit
import CoreLocation

class InitialViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        setupUI()
        getLocation()
    }
    
    private func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
        activityIndicator.startAnimating()
    }
    
    private func getLocation() {
        print("bota que tem ")
        let status = CLLocationManager.authorizationStatus()

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            // show alert to user telling them they need to allow location data to use some feature of your app
            let alert = UIAlertController(title: "Permissão para localização", message: "Para que possamos mostrar-lhe as informações mais pertinentes para si, por favor permita a localização do seu dispositivo em Definições -> Proxi_mo :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }

        /*if(status == .notDetermined) {
            print("vim aqui")
            locationManager.requestAlwaysAuthorization()
            return
        }*/

        locationManager.requestLocation()
    }
    
    private func goToLocationViewController(district: String, county: String, parish: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "locationViewController") as! UINavigationController
        let locationViewController = newViewController.viewControllers.first as! LocationViewController
        newViewController.modalPresentationStyle = .fullScreen
        locationViewController.district = district
        locationViewController.county = county
        locationViewController.parish = parish
        self.present(newViewController, animated: true, completion: nil)
    }
}

extension InitialViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("User allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("User allow app to get location data only when app is active")
        case .denied:
            print("User tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("Parental control setting disallow location data")
        case .notDetermined:
            print("The location permission dialog haven't shown before, user haven't tap allow/disallow")
        default:
            print("There is no information about being given permission to locate the user")
        }
    }
    
    // didUpdateLocations locations: is called only once when we use .requestLocation.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Latitude: \(location.coordinate.latitude)")
            print("Longitude: \(location.coordinate.longitude)")
            
            let lat = 40.6144522
            let long = -8.630749
            
            if let loc = CLLocation(latitude: lat, longitude: long) as? CLLocation {
                CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
                    if let placemark = placemarks?[0]  {
                        guard let dist = placemark.administrativeArea else { return }
                        guard let loc = placemark.locality else { return }
                        guard let subLoc = placemark.subLocality else { return }
                        self.defaults.set(dist, forKey: "district")
                        self.defaults.set(loc, forKey: "county")
                        self.defaults.set(subLoc, forKey: "parish")
                        print("\n\(dist), \(loc), \(subLoc)")
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.goToLocationViewController(district: dist, county: loc, parish: subLoc)
                    }
                })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error: \(error.localizedDescription)")
    }
}
