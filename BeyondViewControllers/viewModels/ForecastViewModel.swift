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
    
    fileprivate let forecasts: [ForecastDay]
    
    /// The currently-selected ForecastDay for details purposes.
    var selectedDay: ForecastDay? = nil
    
    init(locationFinder: LocationFinder) {
        self.locationFinder = locationFinder
        
        // Fake ze data for ze 10-day forecast.
        let allConditions: [ForecastDay.Conditions] = [.sunny, .partlyCloudy, .cloudy, .snow]
        let count32 = UInt32(allConditions.count)
        let now = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        forecasts = (0..<10).map {
            index in
            let date = calendar.date(byAdding: .day, value: index, to: now)!
            let low = 5 + Int(arc4random_uniform(20))
            let high = low + Int(arc4random_uniform(20))
            let conditionIndex = Int(arc4random_uniform(count32))
            let conditions = allConditions[conditionIndex]
            let description = "This is the forecast for \(dateFormatter.string(from: date)). The high will be \(high)°F, with overnight lows around \(low)°F. Expect \(conditions.displayable) conditions all day."
            let forecast = ForecastDay(date: date, high: high, low: low, conditions: conditions, iconName: conditions.iconName, text: description)
            return forecast
        }
    }
    
    /// This particular view model has no tear-down because it doesn't make API or file system requests.
    func prepareForRemoval() {
    }
}

extension ForecastViewModel: ForecastViewControllerDataSource {
    
    /// Return the location from the locationFinder.
    func getLocation(completion: @escaping (String) -> Void) {
        locationFinder.getLocation { (placeName) in
            completion(placeName)
        }
    }
    
    /// In a real app, this would involve an API call to the server to download forecast data for
    /// for the user's current location.
    func getForecast(completion: @escaping (Result<[ForecastDay], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { 
            completion(.success(self.forecasts))
        }
    }
}

extension ForecastViewModel: ForecastDetailsViewControllerDataSource {
    /// Return the currently-selected ForecastDay.
    var forecast: ForecastDay {
        guard let day = selectedDay else {
            preconditionFailure("Requesting the selected day when none exists.")
        }
        return day
    }
}
