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
    
    private var forecast: ForecastDay!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        forecast = dataSource.forecast
        
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
