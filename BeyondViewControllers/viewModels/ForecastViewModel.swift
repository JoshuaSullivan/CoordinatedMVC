//
//  ForecastViewModel.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/6/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

class ForecastViewModel {
    
    /// Holding on to the data task returned by the APIClient.
    fileprivate var dataTask: URLSessionDataTask?
    
    fileprivate let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func prepareForRemoval() {
        dataTask?.cancel()
    }
}
