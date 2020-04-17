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

    @IBOutlet weak var getLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    let dispatchGroup = DispatchGroup()
    var districtFromGPS: String = ""
    var countyFromGPS: String = ""
    var parishFromGPS: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        setupUI()
        getLocation()
        getLocationButton.isEnabled = false
    }
    
    private func setupUI() {
        getLocationButton.layer.cornerRadius = 10
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor.init(red: 156/255, green: 176/255, blue: 245/255, alpha: 1.0)
        navigationItem.standardAppearance = appearance
    }
    
    private func getLocation() {
        print("bota que tem ")
        let status = CLLocationManager.authorizationStatus()

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            // show alert to user telling them they need to allow location data to use some feature of your app
            let alert = UIAlertController(title: "Permissão para localização", message: "Para que possamos mostrar-lhe as informações mais pertinentes para si, precisamos do acesso à sua localização :)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Permitir", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }

        if(status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
            return
        }

        locationManager.requestLocation()
        print("pedi a location")
    }
    
    // por implementar mais tarde
    @IBAction func getUserLocation(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as?
            LocationViewController {
            destination.district = districtFromGPS
            destination.county = countyFromGPS
            destination.parish = parishFromGPS
        }
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
        }
    }
    
    // didUpdateLocations locations: is called only once when we use .requestLocation.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            print("Latitude: \(location.coordinate.latitude)")
            print("Longitude: \(location.coordinate.longitude)")
            
            let lat = 40.6144522
            let long = -8.630749
            
            if let loc = CLLocation(latitude: lat, longitude: long) as? CLLocation {
                CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
                    if let placemark = placemarks?[0]  {
                        let name = placemark.name!
                        let country = placemark.country!
                        let region = placemark.administrativeArea!
                        self.districtFromGPS = region
                        let city = placemark.subAdministrativeArea
                        let locality = placemark.locality
                        guard let loc = locality else { return }
                        self.countyFromGPS = loc
                        let subLocality = placemark.subLocality
                        guard let subLoc = subLocality else { return }
                        self.parishFromGPS = subLoc
                        print("\n\(name), \(locality), \(subLocality), \(city), \(region) \(country)")
                        self.getLocationButton.isEnabled = true
                    }
                })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error: \(error.localizedDescription)")
    }
}
