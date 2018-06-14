//
//  ProjectDetailsViewController.swift
//  Xapo
//
//  Created by Cristian Florin Ghinea on 14/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    // MARK: - Properties
    var project: Project?
    
    // MARK: - IBOutlets
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var ratingContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inits()
    }
    
    fileprivate func inits() {
        
        self.title = project?.title
        self.descriptionLabel.text = project?.projectDescription
        
        self.ratingContainerView.layer.borderColor = XapoColors.Brand.cgColor
        self.ratingContainerView.layer.borderWidth = 1.0
    }
}
