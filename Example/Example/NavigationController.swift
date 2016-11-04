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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        
        // If change the start coordinates
        setUp(initialCoordinate: (0, 0))
    }
}

// MARK: - UINavigationcontrollerDelegate
extension NavigationController {
    override func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // If use custom transion
        // return CustomTransionAnimator()
        return super.navigationController(navigationController, animationControllerFor: operation, from: fromVC, to: toVC)
    }
}
