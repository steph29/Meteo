//
//  ViewController.swift
//  Meteo
//
//  Created by stephane verardo on 20/11/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet var background: UIView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tappedUpdateButton(_ sender: Any) {
        WeatherService.getWeather { (sucess, weather) in
            if sucess, let weather = weather {
                self.update(weather: weather)
            }
            else {
                self.alert()
            }
        }
    }
    func setWeather(weather: WeatherDescription, description: String, temp: Int){
         weatherDescriptionLabel.text = description ?? "..."
         tempLabel.text = "\(temp)"
        print(weather.weather[0].icon!)
         switch weather.weather[0].icon! {
            
          //  01d.png     01n.png     clear sky
         //   02d.png     02n.png     few clouds
           // 03d.png     03n.png     scattered clouds
            //04d.png     04n.png     broken clouds
          //  09d.png     09n.png     shower rain
           // 10d.png     10n.png     rain
            //11d.png     11n.png     thunderstorm
            //13d.png     13n.png     snow
            //50d.png     50n.png     mist
            case "01d":
             weatherImage.image = UIImage(systemName: "sun.max")
             background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "02d":
            weatherImage.image = UIImage(systemName: "cloud.sun")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "03d":
            weatherImage.image = UIImage(systemName: "cloud.sun")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "04d":
            weatherImage.image = UIImage(systemName: "cloud")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "09d":
            weatherImage.image = UIImage(systemName: "cloud.heavyrain")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "10d":
            weatherImage.image = UIImage(systemName: "cloud.rain")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "11d":
            weatherImage.image = UIImage(systemName: "cloud.bolt")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "13d":
            weatherImage.image = UIImage(systemName: "snow")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "50d":
            weatherImage.image = UIImage(systemName: "cloud.fog")
            background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
            case "01n":
            weatherImage.image = UIImage(systemName: "moon.stars")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "02n":
            weatherImage.image = UIImage(systemName: "cloud.moon")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "03n":
            weatherImage.image = UIImage(systemName: "cloud.moon")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "04n":
            weatherImage.image = UIImage(systemName: "cloud")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "09n":
            weatherImage.image = UIImage(systemName: "cloud.heavyrain")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "10n":
            weatherImage.image = UIImage(systemName: "cloud.rain")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "11n":
            weatherImage.image = UIImage(systemName: "cloud.bolt")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "13n":
            weatherImage.image = UIImage(systemName: "snow")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
            case "50n":
            weatherImage.image = UIImage(systemName: "cloud.fog")
            background.backgroundColor = UIColor(red: 0.42, green: 0.55, blue: 0.71, alpha: 1.0)
           
    
         default:
             weatherImage.image = UIImage(systemName: "zzz")
             background.backgroundColor = UIColor(red: 0.97, green: 0.70, blue: 0.35, alpha: 1.0)
         }
     }
    
    private func update(weather: WeatherDescription) {
        setWeather(weather: weather, description: weather.weather[0].description!, temp: (Int(weather.main.temp!)))
        localLabel.text = weather.name!
    }
    
    private func alert() {
        let alertVC = UIAlertController(title: "Error", message: "Ooops, The weather download failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
