//
//  ViewController.swift
//  Meteo
//
//  Created by stephane verardo on 20/11/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum backgroundColor {
    case day, night
}

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet var background: UIView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageLabelView: UIImageView!
    @IBOutlet weak var dateFourLabel: UILabel!
    @IBOutlet weak var dateTreeLabel: UILabel!
    @IBOutlet weak var dateTwoLabel: UILabel!
    @IBOutlet weak var dateOneLabel: UILabel!
    var location = Location()
    @IBOutlet weak var weatherImageOne: UIImageView!
    var forecast = WeatherForecast()
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var weatherImageTwo: UIImageView!
    @IBOutlet weak var weatherImageTree: UIImageView!
    @IBOutlet weak var weatherImageFour: UIImageView!
    @IBOutlet weak var weatherImageFive: UIImageView!
    @IBOutlet weak var thinkLabel: UITextField!
    var str = StringFile()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherService.getWeather{ (sucess, weather) in
            if sucess, let weather = weather {
                self.update(weather: weather)
            }
            else {
                self.alert()
            }
        }
        WeatherForecast.getForecast { (success, forecast) in
            if success, let forecast = forecast {
                self.updateForecast(forecast: forecast)
            }
            else {
                self.alert()
            }
        }
    }
  
    @IBAction func tappedUpdateButton(_ sender: Any) {
         WeatherService.getWeather{ (sucess, weather) in
             if sucess, let weather = weather {
                 self.update(weather: weather)
             }
             else {
                 self.alert()
             }
         }
         WeatherForecast.getForecast { (success, forecast) in
             if success, let forecast = forecast {
                 self.updateForecast(forecast: forecast)
             }
             else {
                 self.alert()
             }
         }
    }
    
    private func updateForecast(forecast: Forecast){
        setForecast(forecast: forecast)
    }
    private func update(weather: WeatherDescription) {
        location.localisation()
        setWeather(weather: weather, description: weather.weather[0].description!, temp: (Int(weather.main.temp!)), tempMax: (Int(weather.main.temp_max!)), tempMin: (Int(weather.main.temp_min!)))
           localLabel.text = weather.name!
           dateForecast(weather: weather)
        print(forecast)
       }
    
    func setWeather(weather: WeatherDescription, description: String, temp: Int, tempMax: Int, tempMin: Int){
          weatherDescriptionLabel.text = description
          tempLabel.text = "\(temp)"
        tempMaxLabel.text = "Max: \(tempMax) C"
        tempMinLabel.text = "Min: \(tempMin) C"
         imageIcon(image: weatherImage, weather: weather)
      }
    
    func setForecast(forecast: Forecast){
        imageIconForecast(image: weatherImageOne, forecast: forecast)
        imageIconForecast(image: weatherImageTwo, forecast: forecast)
        imageIconForecast(image: weatherImageTree, forecast: forecast)
        imageIconForecast(image: weatherImageFour, forecast: forecast)
        imageIconForecast(image: weatherImageFive, forecast: forecast)
    }
    
    func imageIconForecasts(image: UIImageView, icon: String){
        switch icon {
            case "01d":
                image.image = UIImage(systemName: "sun.max")
                case "02d":
                image.image = UIImage(systemName: "cloud.sun")
                case "03d":
                image.image = UIImage(systemName: "cloud.sun")
                case "04d":
                image.image = UIImage(systemName: "cloud")
                case "09d":
                image.image = UIImage(systemName: "cloud.heavyrain")
                case "10d":
                image.image = UIImage(systemName: "cloud.rain")
                case "11d":
                image.image = UIImage(systemName: "cloud.bolt")
                case "13d":
                image.image = UIImage(systemName: "snow")
                case "50d":
                image.image = UIImage(systemName: "cloud.fog")
                case "01n":
                image.image = UIImage(systemName: "moon.stars")
                case "02n":
                image.image = UIImage(systemName: "cloud.moon")
                case "03n":
                image.image = UIImage(systemName: "cloud.moon")
                case "04n":
                image.image = UIImage(systemName: "cloud")
                case "09n":
                image.image = UIImage(systemName: "cloud.heavyrain")
                case "10n":
                image.image = UIImage(systemName: "cloud.rain")
                case "11n":
                image.image = UIImage(systemName: "cloud.bolt")
                case "13n":
                image.image = UIImage(systemName: "snow")
                case "50n":
                image.image = UIImage(systemName: "cloud.fog")
                
            default:
                image.image = UIImage(systemName: "zzz")
            }
        
        
        }

    func imageIconForecast(image: UIImageView, forecast: Forecast) {
       imageIconForecasts(image: weatherImageOne, icon: forecast.list[8].weather[0].icon)
        imageIconForecasts(image: weatherImageTwo, icon: forecast.list[16].weather[0].icon)
        imageIconForecasts(image: weatherImageTree, icon: forecast.list[24].weather[0].icon)
        imageIconForecasts(image: weatherImageFour, icon: forecast.list[32].weather[0].icon)
        imageIconForecasts(image: weatherImageFive, icon: forecast.list[39].weather[0].icon)
    }
    
    func imageIcon(image: UIImageView, weather: WeatherDescription) {
        switch weather.weather[0].icon! {
                case "01d":
                image.image = UIImage(systemName: "sun.max")
                thinkLabel.text = str.sun
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "02d":
                image.image = UIImage(systemName: "cloud.sun")
                thinkLabel.text = str.cloud
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "03d":
                image.image = UIImage(systemName: "cloud.sun")
                thinkLabel.text = str.cloud
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "04d":
                image.image = UIImage(systemName: "cloud")
                thinkLabel.text = str.cloud
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "09d":
                image.image = UIImage(systemName: "cloud.heavyrain")
                thinkLabel.text = str.heavyRain
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "10d":
                image.image = UIImage(systemName: "cloud.rain")
                thinkLabel.text = str.rain
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "11d":
                image.image = UIImage(systemName: "cloud.bolt")
                thinkLabel.text = str.rain
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "13d":
                image.image = UIImage(systemName: "snow")
                thinkLabel.text = str.snow
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "50d":
                image.image = UIImage(systemName: "cloud.fog")
                thinkLabel.text = str.fog
                thinkLabel.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
                case "01n":
                image.image = UIImage(systemName: "moon.stars")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "02n":
                image.image = UIImage(systemName: "cloud.moon")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "03n":
                image.image = UIImage(systemName: "cloud.moon")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "04n":
                image.image = UIImage(systemName: "cloud")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "09n":
                image.image = UIImage(systemName: "cloud.heavyrain")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "10n":
                image.image = UIImage(systemName: "cloud.rain")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "11n":
                image.image = UIImage(systemName: "cloud.bolt")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "13n":
                image.image = UIImage(systemName: "snow")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
                case "50n":
                image.image = UIImage(systemName: "cloud.fog")
                background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            default:
                image.image = UIImage(systemName: "zzz")
                background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            }
    }
    
 
    
    func dateForecast(weather: WeatherDescription) {
        let date = Date(timeIntervalSince1970: weather.dt!)
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        dateOneLabel.text = String(day + 1)
        dateTwoLabel.text = String(day + 2)
        dateLabel.text = String(day + 3)
        dateTreeLabel.text = String(day + 4)
        dateFourLabel.text = String(day + 5)
    }

    private func alert() {
        let alertVC = UIAlertController(title: "Error", message: "Ooops, The weather download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
