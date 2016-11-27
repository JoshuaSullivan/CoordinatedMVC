//
//  LocationFinder.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

protocol LocationFinder {
    
    /// The closure is guaranteed to return a string.
    typealias RequestCompletion = (String) -> Void
    
    /// Get a query string to use with the API.
    func getLocationQueryString(completion: @escaping RequestCompletion)
}
