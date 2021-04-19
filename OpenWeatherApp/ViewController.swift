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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateUpperView()

    }

    //MARK: updateUpperView
    private func updateUpperView() {
        self.upperView.weatherInfo = appDelegate.weatherInfo.first
    }
    
    
    func getFiveDaysForcast() {
        
        guard let locationDetails =  appDelegate.locationArray.first else {
            return
        }
        
        NetworkService.shared.getFiveDaysWeather(router: Router.fivedaysForcast, locationdetails: locationDetails) { (result) in
            self.appDelegate.fiveDayForcast.append(result)

        } onError: { (error) in
            self.presentErrorAlertController(error: error.description)
        }
    }
    
}
