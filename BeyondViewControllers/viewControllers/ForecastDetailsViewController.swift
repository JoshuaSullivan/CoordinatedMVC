//
//  ForecastDetailsViewController.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/27/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

protocol ForecastDetailsViewControllerDataSource: class {
    var forecast: ForecastDay { get }
}

class ForecastDetailsViewController: UIViewController {

    weak var dataSource: ForecastDetailsViewControllerDataSource!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var forecast: ForecastDay!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        forecast = dataSource.forecast
        
        navigationItem.title = forecastDateFormatter.string(from: forecast.date)
        imageView.image = UIImage(named: forecast.iconName)
        highLabel.text = "High: \(forecast.high)°F"
        lowLabel.text = "Low: \(forecast.low)°F"
        descriptionLabel.text = forecast.text
        
        // Do any additional setup after loading the view.
    }
}
