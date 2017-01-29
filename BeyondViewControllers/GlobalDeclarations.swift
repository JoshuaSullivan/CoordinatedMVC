//
//  GlobalDeclarations.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 1/29/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import Foundation

let forecastDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMdd", options: 0, locale: Locale.current)
    return df
}()
