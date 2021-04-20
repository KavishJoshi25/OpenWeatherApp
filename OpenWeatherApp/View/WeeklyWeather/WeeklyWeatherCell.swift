//
//  WeeklyWeatherCell.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class WeeklyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var forecastArray: [WeeklyForecast]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cellHeight = collectionView.bounds.height
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: cellHeight)
        }
        
    }
}

extension WeeklyWeatherCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = forecastArray else {
            return 0
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekdayWeatherCell", for: indexPath) as! WeekdayWeatherCell
        cell.forecast = forecastArray?[indexPath.row]
        return cell
    }
}

extension WeeklyWeatherCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 35)
    }
}
