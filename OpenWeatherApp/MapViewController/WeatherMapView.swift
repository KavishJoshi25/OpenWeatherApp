//
//  WeatherMapView.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/17/21.
//

import Foundation
import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    
    var txtLocaltionDetails :String!
    var buttonBookMark: UIButton!
    
    override init() {
        super.init()
        self.setupBookMarkButton()
    }
    
    func setupBookMarkButton() {
        let image = UIImage(named: "star_un_selected")
        buttonBookMark.setImage(image, for: .normal)
        buttonBookMark.addTarget(self, action: #selector(bookMarkButtonAction(sender:)), for: .touchUpInside)
    }
    
    @objc @IBAction func bookMarkButtonAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let imageName = sender.isSelected ? "star" : "star_un_selected"
        let image = UIImage(named: imageName)
        buttonBookMark.setImage(image, for: .normal)
    }
}

class WeatherMapView: MKMapView {
    
    private(set) var locationDetail = LocationDetail()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locationManager = CLLocationManager()
    
    public func setupMapView() {
        delegate = self
        self.showsUserLocation = true
        self.addGestures()
        updateLocation()
    }
    
    private func updateLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        
        self.reloadMap()
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    
    
    private func reloadMap() {
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            self.setRegion(viewRegion, animated: false)
        }
    }
    
    private func addGestures() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressMap(sender:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func didLongPressMap(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self)
            let touchCoordinate = self.convert(touchPoint, toCoordinateFrom: self)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinate
            annotation.title = ""
            self.addAnnotation(annotation) //drops the pin
            print("lat:  \(touchCoordinate.latitude)")
            let lattitude = touchCoordinate.latitude as NSNumber
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 4
            formatter.minimumFractionDigits = 4
            _ = formatter.string(from: lattitude)
            print("long: \(touchCoordinate.longitude)")
            let longitude = touchCoordinate.longitude as NSNumber
            let formatter1 = NumberFormatter()
            formatter1.maximumFractionDigits = 4
            formatter1.minimumFractionDigits = 4
            _ = formatter1.string(from: longitude)
            
            // Add below code to get address for touch coordinates.
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
            
            geoCoder.reverseGeocodeLocation(location, completionHandler:
                                                {
                                                    placemarks, error -> Void in
                                                    
                                                    var street = ""
                                                    var location = ""
                                                    // Place details
                                                    guard let placeMark = placemarks?.first else { return }
                                                    
                                                    // Location name
                                                    if let locationName = placeMark.location {
                                                        print(locationName)
                                                    }
                                                    // Street address
                                                    if let street = placeMark.thoroughfare {
                                                        print(street)
                                                    }
                                                    // City
                                                    if let city = placeMark.subAdministrativeArea {
                                                        print(city)
                                                        location = city
                                                    }
                                                    // Zip code
                                                    if let zip = placeMark.isoCountryCode {
                                                        print(zip)
                                                    }
                                                    // Country
                                                    if let country = placeMark.country {
                                                        print(country)
                                                    }
                                                    if let name = placeMark.name {
                                                        print(name)
                                                        street = name
                                                        
                                                    }
                                                    self.locationDetail = LocationDetail(locationName: location, locationStreet: street, lat: touchCoordinate.latitude, long: touchCoordinate.longitude)
                                                    annotation.title = street + "\n" + location
                                                    
                                                })        }
    }
    
    private func getLocationDetails(lat: Double, long: Double) {
        // Add below code to get address for touch coordinates.
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
                                                placemarks, error -> Void in
                                                
                                                var street = ""
                                                var location = ""
                                                // Place details
                                                guard let placeMark = placemarks?.first else { return }
                                                
                                                // Location name
                                                if let locationName = placeMark.location {
                                                    print(locationName)
                                                }
                                                // Street address
                                                if let street = placeMark.thoroughfare {
                                                    print(street)
                                                }
                                                // City
                                                if let city = placeMark.subAdministrativeArea {
                                                    print(city)
                                                    location = city
                                                }
                                                // Zip code
                                                if let zip = placeMark.isoCountryCode {
                                                    print(zip)
                                                }
                                                // Country
                                                if let country = placeMark.country {
                                                    print(country)
                                                }
                                                if let name = placeMark.name {
                                                    print(name)
                                                    street = name
                                                    
                                                }
                                                self.locationDetail = LocationDetail(locationName: location, locationStreet: street, lat: lat, long: long)
                                                
                                            })
    }
}




extension WeatherMapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard  let lat = view.annotation?.coordinate.latitude,
               let long = view.annotation?.coordinate.longitude else { return }
        self.getLocationDetails(lat: lat, long: long)
    }
}


extension WeatherMapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            self.reloadMap()
        }
    }
}
