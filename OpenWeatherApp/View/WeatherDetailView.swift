//
//  WeatherDetailView.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//

import UIKit

class WeatherDetailView: FancyView {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var topLabel1: UILabel!
    @IBOutlet weak var topLabel2: UILabel!
    @IBOutlet weak var topLabel3: UILabel!
    @IBOutlet weak var topLabel4: UILabel!
    @IBOutlet weak var topLabel5: UILabel!
    
    @IBOutlet weak var bottomLabel1: UILabel!
    @IBOutlet weak var bottomLabel2: UILabel!
    @IBOutlet weak var bottomLabel3: UILabel!
    @IBOutlet weak var bottomLabel4: UILabel!
    @IBOutlet weak var bottomLabel5: UILabel!
    
    
    var istoday: Bool = true {
        didSet {
            self.showTodayWeather(val: self.istoday)
        }
    }
    
    func getSelectedTitle() -> Int {
        let index = segmentedControl.selectedSegmentIndex
        return index
    }
    
    func clear() {
        let labels = [topLabel1, topLabel2, topLabel3, topLabel4, topLabel5, bottomLabel1, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5]
        for label in labels {
            label?.text = ""
        }
    }
    
    func updateTodaysView(result: [Result]) {
        
        let weatherTemperature = result.first?.main.temp
        if let temp = weatherTemperature?.rounded() {
            topLabel1.text = "\(temp) F"
        }
        if let humid = result.first?.main.humidity {
            bottomLabel1.text = "H:\(humid)"
        }
    }
    
    private func showTodayWeather(val: Bool) {
        print(self.getSelectedTitle())
        let labels = [ topLabel2, topLabel3, topLabel4, topLabel5, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5]
        
        for i in 0...labels.count - 1 {
            labels[i]?.isEnabled = istoday
        }
    }
    
}
    
