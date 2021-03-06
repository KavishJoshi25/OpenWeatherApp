//
//  MapViewController.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/17/21.
//

import Foundation
import UIKit


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: WeatherMapView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setupMapView()
    }
    
    @IBAction func addFavouriteAction() {
        
        if !mapView.locationDetail.locationName.isEmpty && !mapView.locationDetail.locationName.isEmpty {
            
            appDelegate.locationArray.append(mapView.locationDetail)            

            NetworkService.shared.getWeather(router: Router.todaysForcast, locationdetails: mapView.locationDetail) { (result) in
                self.appDelegate.weatherInfo.append(result)

            } onError: { (error) in
                self.presentErrorAlertController(error: error.description)
            }
        }
    }
    
}
