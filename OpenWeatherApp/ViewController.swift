//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet private weak var upperView: RightNowView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionViewLayout()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateUpperView()
        self.getFiveDaysForcast()

    }

    //MARK: updateUpperView
    private func updateUpperView() {
        self.upperView.weatherInfo = appDelegate.weatherInfo.first
    }
    
    
    private func getFiveDaysForcast() {
        
        guard let locationDetails =  appDelegate.locationArray.first else {
            return
        }
        
        NetworkService.shared.getFiveDaysWeather(router: Router.fivedaysForcast, locationdetails: locationDetails) { (result) in
            
            self.appDelegate.fiveDayForcast.append(result)
            self.collectionView.reloadData()


        } onError: { (error) in
            self.presentErrorAlertController(error: error.description)
        }
    }
    
    private func setupCollectionViewLayout() {
        guard
            let collectionView = collectionView,
            let layout = collectionView.collectionViewLayout as? WeatherLayout else {
                return
        }
        
        collectionView.register(UINib(nibName: "WeatherHeaderView", bundle: nil),
                                forSupplementaryViewOfKind: WeatherLayout.Element.WeatherHeaderView.kind,
                                withReuseIdentifier: WeatherLayout.Element.WeatherHeaderView.id)

                
        let width = UIScreen.main.bounds.width
        
        layout.itemSize = CGSize(width: width, height: 100)
        layout.headerSize = CGSize(width: width, height: 270)
        layout.cellTodayWeatherSize = CGSize(width: width, height: 100)
        layout.cellWeeklyWeatherSize = CGSize(width: width, height: 210)
        layout.cellSummaryWeatherSize = CGSize(width: width, height: 70)
        layout.cellDetailTodayWeatherSize = CGSize(width: width, height: 235)
    }
    
}


extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayWeatherCell", for: indexPath) as! TodayWeatherCell
            let array = get2DaysForecast()
            cell.forecastArray = array
            cell.collectionView.reloadData()
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeeklyWeatherCell", for: indexPath) as! WeeklyWeatherCell
            cell.collectionView.reloadData()
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SummaryCell", for: indexPath) as! SummaryTodayWeatherCell
            cell.weather = self.appDelegate.weatherInfo.first?.main
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailTodayWeatherCell
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
}


extension ViewController {
    
    private func get2DaysForecast() -> [FList] {
        var twoDaysArr: [FList] = []
        if let arr = self.appDelegate.fiveDayForcast.first?.list,  arr.count  > 0  {
                for i in 0..<12 {
                    
                        twoDaysArr.append(arr[i] )
                }
        }
       
        return twoDaysArr
    }
}
