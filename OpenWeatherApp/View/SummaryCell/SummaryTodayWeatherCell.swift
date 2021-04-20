//
//  SummaryTodayWeatherCell.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class SummaryTodayWeatherCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var weather: Main? {
        didSet {
            if let data = weather {
                
                let temp = WeatherManager.convertTemp(temp: data.temp, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
                
                let temp_max = WeatherManager.convertTemp(temp: data.tempMax, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
                let temp_min = WeatherManager.convertTemp(temp: data.tempMin, from: .kelvin, to: .celsius, tempStringUnit: .withDegree)
                let str = String(format: "Today: %@ currently. The high will be %@ and the low will be %@.", temp, temp_max, temp_min)
                descriptionLabel.text = str
            }
        }
    }
}
