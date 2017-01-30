//
//  Result.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Swift

/// The result of an asynchronous request.
public enum Result<SuccessType, ErrorType> {
    /// The request succeeded.
    case success(SuccessType)
    
    /// The request failed.
    case failure(ErrorType)
}
