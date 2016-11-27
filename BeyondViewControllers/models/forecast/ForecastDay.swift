//
//  ForecastDay.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import Foundation

struct ForecastDay {
    let date: Date
    let high: Int
    let low: Int
    let conditions: String
    let iconUrl: URL
    let text: String
}

extension ForecastDay: JSONConvertible {
    
    private struct Keys {
        static let date = "epoch"
    }
    
    init?(json: JSONDictionary) {
        guard
            let rawDate = json[Keys.date] as? Double
            else {
                return nil
        }
        let date = Date(timeIntervalSince1970: rawDate)
        return nil
    }
}
