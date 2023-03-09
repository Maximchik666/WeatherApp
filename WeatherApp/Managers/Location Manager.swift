//
//  Location Manager.swift
//  WeatherApp
//
//  Created by Maksim Kruglov on 09.03.2023.
//

import Foundation
import CoreLocation

class LocationManager {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    func findUserLocation() -> (Double, Double)?{
        
        print("77777777777777777777\(locationManager.authorizationStatus)")
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("Latitude: \(latitude), Longitude: \(longitude)")
            return (latitude, longitude)
        } else {
            print("Unable to get current location.")
            return nil
        }
    }
}




