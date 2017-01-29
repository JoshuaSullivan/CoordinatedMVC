//
//  ForecastViewModel.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/6/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

class ForecastViewModel {
    
    fileprivate let locationFinder: LocationFinder
    
    init(locationFinder: LocationFinder) {
        self.locationFinder = locationFinder
    }
    
    func prepareForRemoval() {
    }
}

extension ForecastViewModel: ForecastViewControllerDataSource {
    
    func getLocation(completion: @escaping (String) -> Void) {
        locationFinder.getLocation { (placeName) in
            completion(placeName)
        }
    }
    
    /// In a real app, this would involve an API call to the server to download forecast data for
    /// for the user's current location.
    func getForecast(completion: @escaping (Result<[ForecastDay], Error>) -> Void) {
        
    }
}
