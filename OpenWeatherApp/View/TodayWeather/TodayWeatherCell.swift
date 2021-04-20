//
//  TodayWeatherCell.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/19/21.
//

import UIKit

class TodayWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var forecastArray: [FList]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        
        let cellHeight = collectionView.bounds.height
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: cellHeight)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension TodayWeatherCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = forecastArray else {
            return 0
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeatherCell", for: indexPath) as! HourlyWeatherCell
        cell.forecast = forecastArray?[indexPath.row]
        return cell
    }
}

extension TodayWeatherCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: Int(collectionView.bounds.height))
    }
}
