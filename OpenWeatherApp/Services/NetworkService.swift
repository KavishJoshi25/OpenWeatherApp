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
    
    func getWeather(router : Router ,locationdetails: LocationDetail,onSuccess: @escaping (Result) -> Void, onError: @escaping (String) -> Void) {
     
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        let parameters: [String: String] = [
                    "lat": String(locationdetails.lat),
                    "lon": String(locationdetails.long),
            "appid": router.accessToken
                ]
        
        components.setQueryItems(with: parameters)
        guard let url = components.url else { return}
        print("url----->\(url)")
       
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
    
    
    func getFiveDaysWeather(router : Router ,locationdetails: LocationDetail,onSuccess: @escaping (FiveWeekModel) -> Void, onError: @escaping (String) -> Void) {
     
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        let parameters: [String: String] = [
                    "lat": String(locationdetails.lat),
                    "lon": String(locationdetails.long),
            "appid": router.accessToken
                ]
        
        components.setQueryItems(with: parameters)
        guard let url = components.url else { return}
        print("url----->\(url)")
       
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
                        let items = try JSONDecoder().decode(FiveWeekModel.self, from: data)
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

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
