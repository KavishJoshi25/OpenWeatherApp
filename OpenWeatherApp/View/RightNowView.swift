//
//  RightNowView.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//

import UIKit

class RightNowView: FancyView {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!

    var cityText = "" {
        didSet {
            self.cityLabel.text = "City: " + self.cityText
        }
    }
    
    func setDayAndDate()  {
        self.dateLabel.text = "Day & Date: " + Date.getCurrentDate()
    }

    var weatherText = "" {
        didSet {
            self.weatherLabel.text =  "Weather: " + self.weatherText.capitalized
        }
    }
    
}
