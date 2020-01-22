//
//  WeatherForecast.swift
//  Meteo
//
//  Created by stephane verardo on 10/12/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherForecast: NSObject, CLLocationManagerDelegate {
    static var manager = CLLocationManager()
    static var locVC = ViewController()

        static func getForecast(callback: @escaping (Bool, Forecast?) -> Void) {
            var request = URLRequest(url: locVC.urlForecast())
            request.httpMethod = "POST"
            
            let body = "method=getForecast&format=json"
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
                        let responseJSON = try? JSONDecoder().decode(Forecast.self, from: data)
                            callback(true, responseJSON)
                    }
                    catch {
                        print("Error Json: ", error)
                    }
                }
            }; task.resume()
        }
    }
