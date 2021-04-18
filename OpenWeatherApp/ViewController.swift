//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/17/21.
//

import UIKit

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var upperView: RightNowView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func viewWillAppear(_ animated: Bool) {
        //data is here
        print(appDelegate.weatherInfo)
        if let city = appDelegate.weatherInfo.first?.name {
            upperView.cityText = city
        }
        if let weather = appDelegate.weatherInfo.first?.weather.first?.weatherDescription {
            upperView.weatherText = weather

        }
        upperView.setDayAndDate()
    }

}
