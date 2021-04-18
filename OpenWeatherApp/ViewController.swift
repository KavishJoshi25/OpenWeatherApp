//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet private weak var upperView: RightNowView!
    @IBOutlet private weak var weatherDetailView: WeatherDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(appDelegate.weatherInfo)
        self.updateUpperView()
    }

    private func updateUpperView(){
        if let city = appDelegate.weatherInfo.first?.name {
            self.upperView.cityText = city
        }
        if let weather = appDelegate.weatherInfo.first?.weather.first?.weatherDescription {
            self.upperView.weatherText = weather
        }
        self.upperView.setDayAndDate()
    }
    
}
