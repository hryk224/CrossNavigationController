//
//  CrossViewController.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit

open class CrossViewController: UIViewController {
    open var coordinate: Cross.Coordinate = (0, 0)
    convenience init(coordinate: Cross.Coordinate) {
        self.init()
        self.coordinate = coordinate
    }
    open func differenceCoordinate(toVC: CrossViewController) -> Cross.Coordinate {
        return (x: toVC.coordinate.x - coordinate.x, y: toVC.coordinate.y - coordinate.y)
    }
    open func differenceCoordinate(fromVC: CrossViewController) -> Cross.Coordinate {
        return fromVC.differenceCoordinate(toVC: self)
    }
    open func discrimination(toVC: CrossViewController) -> Cross.Direction? {
        let difference = differenceCoordinate(toVC: toVC)
        switch difference {
        case (_, 0):
            return difference.x > 0 ? .right : .left
        case (0, _):
            return difference.y > 0 ? .up : .down
        default:
            return nil
        }
    }
    open func discrimination(fromVC: CrossViewController) -> Cross.Direction? {
        return fromVC.discrimination(toVC: self)
    }
}
