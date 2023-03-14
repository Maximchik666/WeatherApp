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
    
    func findUserLocation() -> (Double, Double, String)? {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var locationName = "Initial Place"
        
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            return (latitude, longitude, locationName)
        } else {
            print("Unable to get current location.")
            return nil
        }
    }
    
    func geocoder (querry: String, completion: @escaping ((Double, Double, String)?) -> ()) {
        let geocoder = CLGeocoder()
        var coord: (Double, Double, String)? = nil
        
        geocoder.geocodeAddressString(querry) { (placemarks, error) in
            if let error = error {
                print("Error: \(error)")
            }
            
            print("Placemarks: \(placemarks?[0].name ?? "WROOOOOOOONG"), Error: \(error.debugDescription)")
            
            if let placemarks = placemarks, let location = placemarks.first?.location {
                let latitude = location.coordinate.latitude as Double
                let longitude = location.coordinate.longitude as Double
                print("Latitude: \(latitude), Longitude: \(longitude)")
                coord = (latitude, longitude, placemarks[0].name!)
            }
            completion(coord)
        }
    }
    
    func coordinatesToPlace (lat: Double, lon: Double, completionHandler: @escaping (String)->()) {
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: lon)
        
        geocoder.reverseGeocodeLocation(location) { place, error in
            let point = place?[0].name ?? "ERROR"
            completionHandler (point)
        }
    }
}





