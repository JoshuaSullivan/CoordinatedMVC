//
//  Result.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/4/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Swift

public enum Result<SuccessType, ErrorType> {
    case success(SuccessType)
    case failure(ErrorType)
}
