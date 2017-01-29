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

protocol ForecastDetailsViewControllerDelegate: class {
    func forecastDetails(didTapBack forecastDetails: ForecastDetailsViewController)
}

class ForecastDetailsViewController: UIViewController {

    weak var dataSource: ForecastDetailsViewControllerDataSource!
    weak var delegate: ForecastDetailsViewControllerDelegate!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
