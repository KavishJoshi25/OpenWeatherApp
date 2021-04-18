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
            //insert(mapView.locationDetail)
            
            //TODO: Just to test
            //change the static API call to dynamic            
            NetworkService.shared.getWeather(locationdetails: mapView.locationDetail) { (result) in
                print(result.main)
                print(result.weather)

            } onError: { (error) in
                print(error)
            }
            
        }
        
    }
    
}
