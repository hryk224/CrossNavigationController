//
//  NavigationController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit
import CrossNavigationController

class NavigationController: CrossNavigationController {
    
    let goalCoordinate: Cross.Coordinate = (1, 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Required setup
        configure(manager: Cross(rootCoordinate: (0, 0)))
    }
    
    // If use custom transion
//    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return nil
//    }
}
