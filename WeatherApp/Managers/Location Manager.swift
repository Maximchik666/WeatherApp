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
    
    func findUserLocation() -> (Double, Double, String)?{
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let name = locationManager.location?.description
            return (latitude, longitude, name) as? (Double, Double, String)
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
}





