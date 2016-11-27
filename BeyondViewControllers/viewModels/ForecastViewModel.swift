//
//  ForecastViewModel.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/6/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

class ForecastViewModel {
    
    fileprivate static let apiKey = "7363d24e6b924e33"
    
    /// Holding on to the data task returned by the APIClient.
    fileprivate var dataTask: URLSessionDataTask?
    
    fileprivate let apiClient: APIClient
    fileprivate let locationFinder: LocationFinder
    
    init(apiClient: APIClient, locationFinder: LocationFinder) {
        self.apiClient = apiClient
        self.locationFinder = locationFinder
    }
    
    func prepareForRemoval() {
        dataTask?.cancel()
    }
}

extension ForecastViewModel: ForecastViewControllerDataSource {
    func getForecast(completion: @escaping (Result<[ForecastDay], Error>) -> Void) {
        locationFinder.getLocationQueryString {
            [weak self] query in
            guard let strongSelf = self else { return }
            let urlString = "http://api.wunderground.com/api/\(ForecastViewModel.apiKey)/forecast10day/q/\(query).json"
            guard let url = URL(string: urlString) else {
                assertionFailure("Couldn't create request URL.")
                completion(.failure(AppError.requestFailed))
                return
            }
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15.0)
            strongSelf.dataTask = strongSelf.apiClient.send(request: request, completion: {
                [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let json):
                    print("SUCCESS!")
                    print(json)
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
    
    private func handleForecastResult(result: APIClient.APIRequestCompletion) {
        
    }
}
