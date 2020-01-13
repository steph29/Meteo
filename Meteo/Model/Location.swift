//
//  Location.swift
//  Meteo
//
//  Created by stephane verardo on 12/12/2019.
//  Copyright © 2019 stephane verardo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class Location: NSObject, CLLocationManagerDelegate {
    
        var manager = CLLocationManager()
        let regionInMeters: Double = 750
        var previousLocation: CLLocation?
    
        func checkLocationServices() {
               if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
               } else {
                   
               }
           }
        
        func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                manager.startUpdatingLocation()
            case .denied:
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                // Alert leur expliquant pourquoi c'est bloqué: controle parental ...
                break
            case .authorizedAlways:
                break
            }
        }
        func setupLocationManager() {
            manager.delegate  = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
    }

extension Location: MKMapViewDelegate  {
        
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
            guard let location = locations.last else { return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
      }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
            
        }
    }

