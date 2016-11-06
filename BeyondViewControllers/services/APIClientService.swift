//
//  APIClientService.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/5/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

class APIClientService: APIClient {
    
    func send(request: URLRequest, completion: @escaping APIClient.APIRequestCompletion) -> URLSessionDataTask? {
        let task = URLSession.shared.dataTask(with: request) {
            (optionalData, optionalResponse, optionalError) in
            
            // In a real API Client, we'd be doing response checking and error handling and the like.
            guard let data = optionalData else {
                completion(.failure(APIClientError.requestFailed))
                return
            }
            
            // We're just going to assume the top-level object in the response is a dictionary and not an array.
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary else {
                completion(.failure(APIClientError.jsonParsingFailed))
                return
            }
            
            // Okay, it worked!
            completion(.success(json))
        }
        task.resume()
        return task
    }
}
