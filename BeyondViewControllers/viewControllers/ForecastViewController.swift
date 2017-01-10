//
//  ForecastViewController.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/19/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

protocol ForecastViewControllerDataSource: class {
    func getForecast(completion: @escaping (Result<[ForecastDay], Error>) -> Void)
}

class ForecastViewController: UIViewController {
    
    private let cellSize = CGSize(width: 100.0, height: 130.0)
    private let minSpacing: CGFloat = 10.0
    
    weak var dataSource: ForecastViewControllerDataSource?
    
    fileprivate var forecasts: [ForecastDay] = []

    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource?.getForecast(completion: {
            [weak self] result in
            guard case .success(let forecasts) = result else {
                return
            }
            self?.forecasts = forecasts
        })
        
        self.navigationItem.title = "Forecast"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - minSpacing
        let columns = floor(availableWidth / (cellSize.width + minSpacing))
        let paddingSpace = screenWidth - (cellSize.width * columns)
        let padding = floor(paddingSpace / (columns + 1))
        let insetSpace = floor((paddingSpace - padding * columns) / 2.0)
        self.collectionView?.contentInset = UIEdgeInsets(top: insetSpace, left: insetSpace, bottom: insetSpace, right: insetSpace)
        if let flow = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.minimumInteritemSpacing = padding
            flow.minimumLineSpacing = padding
        }
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ForecastViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
}

//extension ForecastViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }
//}
