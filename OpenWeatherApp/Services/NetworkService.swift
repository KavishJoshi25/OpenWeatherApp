//
//  NetworkService.swift
//  OpenWeatherApp
//
//  Created by Kavish Joshi on 4/18/21.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    let session = URLSession(configuration: .default)
    
    let URL_API_KEY = "fae7190d7e6433ec3a45285ffcf55c86"
    let URL_BASE = "https://api.openweathermap.org/data/2.5"
    var URL_LATITUDE = "60.99"
    var URL_LONGITUDE = "30.0"
    var URL_GET_ONE_CALL = ""

    func setLatitude(_ latitude: String) {
        URL_LATITUDE = latitude
    }
    
    func setLatitude(_ latitude: Double) {
        setLatitude(String(latitude))
    }
    
    func setLongitude(_ longitude: String) {
        URL_LONGITUDE = longitude
    }
    
    func setLongitude(_ longitude: Double) {
        setLongitude(String(longitude))
    }
    
    
    func buildURL() -> String {
        URL_GET_ONE_CALL = "/weather?lat=" + URL_LATITUDE + "&lon=" + URL_LONGITUDE  + "&appid=" + URL_API_KEY
        return URL_BASE + URL_GET_ONE_CALL
    }
    
    
    func getWeather(onSuccess: @escaping (Result) -> Void, onError: @escaping (String) -> Void) {
     
        guard let url = URL(string: buildURL()) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Result.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
}
