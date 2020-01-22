//
//  WeatherService.swift
//  Meteo
//
//  Created by stephane verardo on 20/11/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import Foundation
import CoreLocation


class WeatherService: NSObject, CLLocationManagerDelegate {
    static var manager = CLLocationManager()
   static var vc = ViewController()
    
    static func getWeather(callback: @escaping (Bool, WeatherDescription?) -> Void){
        var request = URLRequest(url: vc.urlWeather())
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

