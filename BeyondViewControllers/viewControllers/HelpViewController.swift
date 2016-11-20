//
//  HelpViewController.swift
//  BeyondViewControllers
//
//  Created by Joshua Sullivan on 11/19/16.
//  Copyright © 2016 Josh Sullivan. All rights reserved.
//

import UIKit

protocol HelpViewControllerDelegate: class {
    func helpViewController(didTapBlog helpController: HelpViewController)
    func helpViewController(didTapTwitter helpController: HelpViewController)
}

class HelpViewController: UIViewController {

    weak var delegate: HelpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction fileprivate func blogTapped(_ sender: Any?) {
        delegate?.helpViewController(didTapBlog: self)
    }
    
    @IBAction fileprivate func twitterTapped(_ sender: Any?) {
        delegate?.helpViewController(didTapTwitter: self)
    }
}
