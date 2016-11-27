//
//  LocationService.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, LocationFinder {
    
    fileprivate static let defaultQuery = "CA/San_Francisco"
    
    fileprivate var locationManager: CLLocationManager
    fileprivate var cachedQueryString: String? = nil
    fileprivate var cacheCreated: Date?
    fileprivate var searchInProgress: Bool = false
    
    fileprivate var requests: [LocationFinder.RequestCompletion] = []
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        super.init()
    }
    
    func getLocationQueryString(completion: @escaping LocationFinder.RequestCompletion) {
        // Check if we have a cached location and if the location is less than 10 minutes old.
        if
            let query = cachedQueryString,
            let cacheDate = cacheCreated,
            cacheDate.timeIntervalSinceNow < 600.0
        {
            completion(query)
            return
        }
        
        requests.append(completion)
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            set(query: LocationService.defaultQuery)
        case .authorizedAlways, .authorizedWhenInUse:
            startSearch()
        }
    }
    
    fileprivate func startSearch() {
        guard !searchInProgress else { return }
        searchInProgress = true
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func stopSearch() {
        searchInProgress = false
        locationManager.stopUpdatingLocation()
    }
    
    fileprivate func set(query: String) {
        cachedQueryString = query
        cacheCreated = Date()
        requests.forEach({ $0(query) })
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Got a location.
            set(query: "\(location.coordinate.latitude),\(location.coordinate.longitude)")
        } else {
            // Didn't get a location.
            set(query: LocationService.defaultQuery)
        }
        stopSearch()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            startSearch()
        default:
            set(query: LocationService.defaultQuery)
        }
    }
}
