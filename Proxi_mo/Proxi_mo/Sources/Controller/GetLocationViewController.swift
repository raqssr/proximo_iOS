//
//  InitialViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit
import CoreLocation

@available(iOS 13.0, *)
final class GetLocationViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        setupUI()
        getLocation()
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = false
        activityIndicator.startAnimating()
    }
    
    private func getLocation() {
        let status = CLLocationManager.authorizationStatus()

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            return
        }

        if(status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }

        print("vou fazer request")
        locationManager.requestLocation()
        print("fiz request")
    }
    
    private func goToLocationViewController(district: String, county: String, parish: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "locationViewController")
            as! UINavigationController
        let locationViewController = newViewController.viewControllers.first as! DisplayLocationViewController
        newViewController.modalPresentationStyle = .fullScreen
        locationViewController.district = district
        locationViewController.county = county
        locationViewController.parish = parish
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func displayAlertForPermission() {
        let alert = UIAlertController(title: "Permissão para localização",
                                      message: "Para que possamos mostrar-lhe as informações mais pertinentes para si, por favor permita a localização do seu dispositivo em Definições -> Proxi_mo.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: {(_) -> Void in
                                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                                            else { return }

                                        if UIApplication.shared.canOpenURL(settingsUrl) {
                                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                                print("Settings opened: \(success)")
                                            })
                                        }
                                    }))
        alert.addAction(UIAlertAction(title: "Não quero",
                                      style: .default,
                                      handler: {(alert: UIAlertAction!) in
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "changeLocationViewController")
                                            as! UINavigationController
                                        newViewController.modalPresentationStyle = .fullScreen
                                        self.present(newViewController, animated: true, completion: nil)
                                    }))
        self.present(alert, animated: true)
    }
}

@available(iOS 13.0, *)
extension GetLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("User allow app to get location data when app is active or in background")
            getLocation()
        case .authorizedWhenInUse:
            print("User allow app to get location data only when app is active")
            getLocation()
        case .denied:
            print("User tap 'disallow' on the permission dialog, cant get location data")
            displayAlertForPermission()
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
            
            if let loc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) as? CLLocation {
                CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
                    if let placemark = placemarks?[0]  {
                        guard let dist = placemark.administrativeArea else { return }
                        guard let loc = placemark.locality else { return }
                        guard let subLoc = placemark.subLocality else { return }
                        self.defaults.set(dist, forKey: "district")
                        self.defaults.set(loc, forKey: "county")
                        self.defaults.set(subLoc, forKey: "parish")
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
