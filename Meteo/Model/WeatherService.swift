//
//  WeatherService.swift
//  Meteo
//
//  Created by stephane verardo on 20/11/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class WeatherService {
    static var location = Location()
    static var loc = CLLocation(latitude:location.manager.location!.coordinate.latitude , longitude: location.manager.location!.coordinate.longitude)
    
    // lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22
    
    static let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.coordinate.latitude)&lon=\(loc.coordinate.longitude)&lang=fr&units=metric&APPID=3d0f03af752e96a61f63461350da3438")!
      
    static func getWeather(callback: @escaping (Bool, WeatherDescription?) -> Void){
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        
        let body = "method=getWeather&format=json"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                do {
                    let responseJSON = try? JSONDecoder().decode(WeatherDescription.self, from: data)
                        callback(true, responseJSON)
                }
                catch {
                    print("Error Json: ", error)
                }
            }
        }; task.resume()
    }
}

