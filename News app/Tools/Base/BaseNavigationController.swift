//
//  BaseNavigationController.swift
//  News app
//
//  Created by hossein shademany on 3/28/19.
//  Copyright © 2019 hossein shademany. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationBar.barTintColor = #colorLiteral(red: 0.08132412285, green: 0.1745293736, blue: 0.3156577349, alpha: 1)
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
