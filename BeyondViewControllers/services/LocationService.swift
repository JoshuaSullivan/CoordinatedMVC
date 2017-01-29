//
//  LocationService.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

/// In a real app, this would be the facade for interacting with CoreLocation.
/// For demo purposes, it simply has fixed data.
class LocationService: LocationFinder {
    
    fileprivate static let defaultLocation = "Bloomington, MN"
    
    fileprivate var requests: [LocationFinder.RequestCompletion] = []
    
    func getLocation(completion: @escaping LocationFinder.RequestCompletion) {
        // Simulate an API delay.
        let deadline = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion(LocationService.defaultLocation)
        }
    }
}

