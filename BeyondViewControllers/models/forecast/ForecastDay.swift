//
//  ForecastDay.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

/// A simple data structure encapsulating a single day's forecst.
struct ForecastDay {
    
    /// The date of the forecast.
    /// - Note: Only the year / month / day is relevant.
    let date: Date
    
    /// The daily high temperature. In degrees Faranheit.
    let high: Int
    
    /// The daily low temperature. In degrees Faranheit.
    let low: Int
    
    /// The current conditions as a displayable string.
    let conditions: String
    
    /// The name of the icon representing the current conditions.
    let iconName: String
    
    /// An extended description of the current conditions.
    let text: String
}

