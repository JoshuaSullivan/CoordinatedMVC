//
//  APIClient.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/5/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String : Any]

/// In a real API Client, this would have all the different error conditions.
public enum APIClientError: Error {
    case requestFailed
    case jsonParsingFailed
}

public protocol APIClient {
    
    /// The APIClient returns its success or failure in a Result enum.
    typealias APIRequestCompletion = (Result<JSONDictionary, APIClientError>) -> Void
    
    /// This form of the send method returns a single object of type `ReturnType`.
    @discardableResult func send(request: URLRequest, completion: @escaping APIRequestCompletion) -> URLSessionDataTask?
}
