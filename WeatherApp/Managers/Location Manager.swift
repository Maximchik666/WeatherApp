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
    
    func getPermissions() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func findUserLocation( completion: @escaping ((Double, Double, String)) -> ()) {
        
        
        if let location = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let placemarks = placemarks {
                    let latitude = location.coordinate.latitude as Double
                    let longitude = location.coordinate.longitude as Double
                    let geolocation = placemarks[0].name ?? "Атлантида"
                    let coord = (latitude, longitude, geolocation)
                    completion(coord)
                } else{
                    completion((0,0, "Атлантида"))
                }
            }
        } else {
            completion ((0,0, "Атлантида"))
        }
    }
        
        func geocoder (querry: String, completion: @escaping ((Double, Double, String)?, Error?) -> ()) {
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
                completion(coord, error)
            }
        }
    }
    
    
    
    
    
