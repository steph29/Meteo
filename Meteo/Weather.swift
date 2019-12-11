//
//  Weather.swift
//  Meteo
//
//  Created by stephane verardo on 20/11/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct WeatherDescription: Codable {
    
    struct Coord: Codable {
        var lon: Double?
        var lat: Double?
    }
    
    struct Weathers: Codable {
        var id: Int?
        var main: String?
        var description: String?
        var icon: String?
    }
    
    struct Main: Codable {
        let temp: Float?
        let pressure: Int?
        let humidity: Int?
        let temp_min: Float?
        let Temp_max: Float?
    }
    
    struct Wind: Codable {
        let speed: Float?
        let deg: Int?
    }

    struct Cloud: Codable {
        let all: Int?
    }
    
    struct Sys: Codable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }
    
    var coord: Coord
    let weather: [Weathers]
    let base: String?
    let main: Main
    let visibilty: Int?
    let wind: Wind
    let clouds: Cloud
    let dt: Double?
    let sys: Sys
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}
