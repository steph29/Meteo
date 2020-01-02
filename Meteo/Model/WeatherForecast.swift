//
//  WeatherForecast.swift
//  Meteo
//
//  Created by stephane verardo on 10/12/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherForecast {
    static var location = Location()

    private static let forecastUrl = URL(string:"https://api.openweathermap.org/data/2.5/forecast?q=Lorient&lang=fr&units=metric&APPID=3d0f03af752e96a61f63461350da3438")!
          
        static func getForecast(callback: @escaping (Bool, Forecast?) -> Void) {
            var request = URLRequest(url: forecastUrl)
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
