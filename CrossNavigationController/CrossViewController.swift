//
//  CrossViewController.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit.UIViewController

open class CrossViewController: UIViewController, CrossControllable {
    open var crossNavigationController: CrossNavigationController? {
        return navigationController as? CrossNavigationController
    }
    open var coordinate: Cross.Coordinate {
        return position
    }
    var position: Cross.Coordinate = (0, 0)
}

// MARK: - Extension
extension CrossViewController {
    open func differenceCoordinate(toVC: CrossViewController) -> Cross.Coordinate {
        return (x: toVC.coordinate.x - coordinate.x, y: toVC.coordinate.y - coordinate.y)
    }
    open func differenceCoordinate(fromVC: CrossViewController) -> Cross.Coordinate {
        return fromVC.differenceCoordinate(toVC: self)
    }
}
