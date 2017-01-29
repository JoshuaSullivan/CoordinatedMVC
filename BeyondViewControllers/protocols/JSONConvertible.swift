//
//  JSONConvertible.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

/// The object type for JSON parsed using JSONSerialization.
typealias JSONDictionary = [String : Any]

protocol JSONConvertible {
    /// Initialize an object with a JDSON dictionary.
    init?(json: JSONDictionary)
}
