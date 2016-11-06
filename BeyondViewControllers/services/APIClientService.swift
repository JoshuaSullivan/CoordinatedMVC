//
//  APIClientService.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/5/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

class APIClientService: APIClient {
    
    func send<ReturnType>(request: URLRequest, completion: @escaping APIClient.APIRequestCompletion<ReturnType>) {
        // Magic goes here.
    }
}
