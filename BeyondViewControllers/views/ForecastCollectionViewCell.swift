//
//  ForecastCollectionViewCell.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 1/7/17.
//  Copyright © 2017 Josh Sullivan. All rights reserved.
//

import UIKit

/// Displays the date, conditions icon and conditions text in the summary collection view.
class ForecastCollectionViewCell: UICollectionViewCell {
    
    static let Identifier = "forecastCollectionViewCellIdentifier"
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
}
