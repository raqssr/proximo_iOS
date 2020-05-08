//
//  InitialViewController.swift
//  Proxi_mo
//
//  Created by raquel ramos on 07/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import UIKit
import CoreLocation

final class GetLocationViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    private let defaults = UserDefaults.standard
    
    let getLocationLabel: UILabel = {
        let waiting = UILabel()
        waiting.text = "Estamos a obter os dados da sua localização, por favor aguarde :)"
        waiting.textColor = UIColor(red: 56/255, green: 56/255, blue: 56/255, alpha: 1.0)
        waiting.textAlignment = .center
        waiting.numberOfLines = 0
        waiting.font = UIFont(name: "ProximaNova-Regular", size: 17.0)
        waiting.translatesAutoresizingMaskIntoConstraints = false
        return waiting
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            ind.style = .large
        } else {
            ind.style = .gray
        }
        ind.contentMode = .scaleToFill
        ind.translatesAutoresizingMaskIntoConstraints = false
        return ind
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()

        getLocation()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 156/255, green: 176/255, blue: 245/255,
                                                                        alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.topItem?.title = "Proxi_mo"
        self.navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(getLocationLabel)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupConstraints() {
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        getLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        getLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        getLocationLabel.bottomAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: -64).isActive = true
    }
    
    private func getLocation() {
        let status = CLLocationManager.authorizationStatus()

        if(status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()){
            return
        }

        if(status == .notDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }

        locationManager.requestLocation()
    }
    
    private func goToLocationViewController(district: String, county: String, parish: String) {
        let displayNavVC = UINavigationController(rootViewController: DisplayLocationViewController())
        displayNavVC.modalPresentationStyle = .fullScreen
        let displayLocationVC = displayNavVC.viewControllers.first as! DisplayLocationViewController
        displayLocationVC.district = district
        displayLocationVC.county = county
        displayLocationVC.parish = parish
        self.navigationController?.pushViewController(displayLocationVC, animated: true)
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
            
            if let loc = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                as? CLLocation {
                CLGeocoder().reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
                    if let placemark = placemarks?[0]  {
                        guard let dist = placemark.administrativeArea else { return }
                        print(dist)
                        guard let loc = placemark.locality else { return }
                        print(loc)
                        guard let subLoc = placemark.subLocality else { return }
                        print(subLoc)
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
