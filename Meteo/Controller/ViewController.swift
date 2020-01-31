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
import Firebase

enum backgroundColor {
    case day, night
}

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    // MARK - Outlet
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
    @IBOutlet weak var weatherImageOne: UIImageView!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var weatherImageTwo: UIImageView!
    @IBOutlet weak var weatherImageTree: UIImageView!
    @IBOutlet weak var weatherImageFour: UIImageView!
    @IBOutlet weak var weatherImageFive: UIImageView!
    @IBOutlet weak var thinkLabel: UITextField!
    @IBOutlet weak var previTroisImageView: UIImageView!
    @IBOutlet weak var previSixImageView: UIImageView!
    @IBOutlet weak var previNeufImageView: UIImageView!
    @IBOutlet weak var treeHoursLabel: UILabel!
    @IBOutlet weak var sixHoursLabel: UILabel!
    @IBOutlet weak var nineHoursLabel: UILabel!
  
    
    // MARK - Variables
    var str = StringFile()
    let regionInMeters: Double = 1000
    var previousLocation: CLLocation?
    var loc = Location()
    var forecast = WeatherForecast()
    
    
    // MARK - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loc.setupLocationManager()
        updateWeather()
    }
   
    
    // MARK - Functions Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
           guard let location = locations.last else { return}
            updateWeather()
    }
     
    func urlForecast() -> URL{
        let forecastUrl = URL(string:"https://api.openweathermap.org/data/2.5/forecast?lat=\(loc.manager.location!.coordinate.latitude)&lon=\(loc.manager.location!.coordinate.longitude)&lang=fr&units=metric&APPID=3d0f03af752e96a61f63461350da3438")!
        return forecastUrl
        
    }
  
    
    func urlWeather() -> URL{
        let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(loc.manager.location!.coordinate.latitude)&lon=\(loc.manager.location!.coordinate.longitude)&lang=fr&units=metric&APPID=3d0f03af752e96a61f63461350da3438")!
        return weatherUrl
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            setupLocationManager()
        } else {
            
        }
    }
    
    func setupLocationManager() {
        loc.manager.delegate  = self
        loc.manager.desiredAccuracy = kCLLocationAccuracyBest
       }
    
    func startTrackingUserLocation() {
        loc.manager.startUpdatingLocation()
    }
    
    func getCenterLocation() -> CLLocation {
        let latitude = loc.manager.location!.coordinate.latitude
        let longitude = loc.manager.location!.coordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            loc.manager.requestWhenInUseAuthorization()
        case .restricted:
            // Alerte leur expliquant pourquoi c'est bloqué: controle parental ...
            break
        case .authorizedAlways:
            break
        }
    }
    
    
    // MARK - Functions Weather and Forecast
    func updateWeather(){
        WeatherService.getWeather{ (sucess, weather) in
            if sucess, let weather = weather {
                self.update(weather: weather)
            }
            else {
                self.alert(text: "Weather Error")
            }
        }
        WeatherForecast.getForecast { (success, forecast) in
            if success, let forecast = forecast {
                self.updateForecast(forecast: forecast)
            }
            else {
                self.alert(text: "Forecast Error")
            }
        }
    }
  
    @IBAction func tappedUpdateButton(_ sender: Any) {
        // TODO: add city via CityViewController -> segue
        
    }
    
    private func updateForecast(forecast: Forecast){
        checkLocationServices()
        setForecast(forecast: forecast)
    }
    private func update(weather: WeatherDescription) {
        checkLocationServices()
        setWeather(weather: weather, description: weather.weather[0].description!, temp: (Int(weather.main.temp!)), tempMax: (Int(weather.main.temp_max!)), tempMin: (Int(weather.main.temp_min!)))
           localLabel.text = weather.name!
           dateForecast(weather: weather)
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
        weatherAtFirstday(forecast: forecast)
        weatherAtSecondDay(forecast: forecast)
        weatherAtThirdDay(forecast: forecast)
        weatherAtFourthDay(forecast: forecast)
        weatherAtFifthDay(forecast: forecast)
        
        imageIconForecasts(image: previTroisImageView, icon: forecast.list[1].weather[0].icon)
        imageIconForecasts(image: previSixImageView, icon: forecast.list[2].weather[0].icon)
        imageIconForecasts(image: previNeufImageView, icon: forecast.list[3].weather[0].icon)
        
    }
    
    func weatherAtFirstday(forecast: Forecast){
        for i in 0...8 {
            if ((dtConcatenated(dt: forecast.list[i].dtTxt)).elementsEqual("12:00:00") == true)
            {
               imageIconForecasts(image: weatherImageOne, icon: forecast.list[i].weather[0].icon)
            }
        }
    }
    func weatherAtSecondDay(forecast: Forecast){
        for i in 9...16 {
            if ((dtConcatenated(dt: forecast.list[i].dtTxt)).elementsEqual("12:00:00") == true)
            {
               imageIconForecasts(image: weatherImageTwo, icon: forecast.list[i].weather[0].icon)
            }
        }
    }
    func weatherAtThirdDay(forecast: Forecast){
        for i in 17...24 {
            if ((dtConcatenated(dt: forecast.list[i].dtTxt)).elementsEqual("12:00:00") == true)
            {
               imageIconForecasts(image: weatherImageTree, icon: forecast.list[i].weather[0].icon)
            }
        }
    }
    func weatherAtFourthDay(forecast: Forecast){
        for i in 25...32 {
            if ((dtConcatenated(dt: forecast.list[i].dtTxt)).elementsEqual("12:00:00") == true)
            {
               imageIconForecasts(image: weatherImageFour, icon: forecast.list[i].weather[0].icon)
            }
        }
    }
    func weatherAtFifthDay(forecast: Forecast){
        for i in 33...39 {
            if ((dtConcatenated(dt: forecast.list[i].dtTxt)).elementsEqual("12:00:00") == true)
            {
               imageIconForecasts(image: weatherImageFive, icon: forecast.list[i].weather[0].icon)
            }
            else {
                imageIconForecasts(image: weatherImageFive, icon: forecast.list[i-1].weather[0].icon)
            }
        }
    }
    
    func dtConcatenated(dt: String) -> String{
        let index = dt.dropFirst(11)
        return(String(index))
    }
    
    func dateForecast(weather: WeatherDescription) {
        let date = Date(timeIntervalSince1970: weather.dt!)
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        let hourFormatter = DateFormatter()
        let dayOne = calendar.date(byAdding: .weekday, value: 1, to: date)
        let dayTwo = calendar.date(byAdding: .weekday, value: 2, to: date)
        let dayTree = calendar.date(byAdding: .weekday, value: 3, to: date)
        let dayFour = calendar.date(byAdding: .weekday, value: 4, to: date)
        let dayFive = calendar.date(byAdding: .weekday, value: 5, to: date)
        
        let hoursTree = calendar.date(byAdding: .hour, value: 3, to: date)
        let hoursSix = calendar.date(byAdding: .hour, value: 6, to: date)
        let hoursNine = calendar.date(byAdding: .hour, value: 9, to: date)
       
        dateFormatter.locale = Locale(identifier: "FR-fr")
        dateFormatter.dateFormat = "EEEE"
        hourFormatter.dateFormat = "HH:00"
        dateOneLabel.text = dateFormatter.string(from: dayOne!)
        dateTwoLabel.text = dateFormatter.string(from: dayTwo!)
        dateLabel.text = dateFormatter.string(from: dayTree!)
        dateTreeLabel.text = dateFormatter.string(from: dayFour!)
        dateFourLabel.text = dateFormatter.string(from: dayFive!)
        treeHoursLabel.text = hourFormatter.string(from: hoursTree!)
        sixHoursLabel.text = hourFormatter.string(from: hoursSix!)
        nineHoursLabel.text = hourFormatter.string(from: hoursNine!)
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
    
    private func alert(text: String) {
        let alertVC = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
        
    }
}


extension ViewController  {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
