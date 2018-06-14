//
//  ProjectDetailsViewController.swift
//  Xapo
//
//  Created by Cristian Florin Ghinea on 14/06/2018.
//  Copyright © 2018 Cristian Florin Ghinea. All rights reserved.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(project?.title)
    }
}
