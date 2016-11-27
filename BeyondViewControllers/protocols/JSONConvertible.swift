//
//  JSONConvertible.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

protocol JSONConvertible {
    init?(json: JSONDictionary)
}
