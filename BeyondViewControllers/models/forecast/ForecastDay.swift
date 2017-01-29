//
//  ForecastDay.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

/// A simple data structure encapsulating a single day's forecst.
public struct ForecastDay {
    
    public enum Conditions: String {
        case sunny
        case partlyCloudy
        case cloudy
        case snow
        
        /// A displayable string for the weather conditions.
        /// - Note: In a full app, you'd want these localized.
        public var displayable: String {
            switch self {
            case .sunny:        return "Sunny"
            case .partlyCloudy: return "Partly Cloudy"
            case .cloudy:       return "Cloudy"
            case .snow:         return "Snow"
            }
        }
        
        /// The Icon name for the weather conditions.
        public var iconName: String {
            return self.rawValue
        }
    }
    
    /// The date of the forecast.
    /// - Note: Only the year / month / day is relevant.
    public let date: Date
    
    /// The daily high temperature. In degrees Faranheit.
    public let high: Int
    
    /// The daily low temperature. In degrees Faranheit.
    public let low: Int
    
    /// The current conditions.
    public let conditions: Conditions
    
    /// The name of the icon representing the current conditions.
    public let iconName: String
    
    /// An extended description of the current conditions.
    public let text: String
}

