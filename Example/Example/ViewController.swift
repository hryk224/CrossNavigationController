//
//  ViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit
import CrossNavigationController

class ViewController: CrossViewController {
    @IBOutlet var upButton :UIButton!
    @IBOutlet var rightButton :UIButton!
    @IBOutlet var downButton :UIButton!
    @IBOutlet var leftButton :UIButton!
    @IBOutlet weak var label: UILabel!

    private let goalCoordinate: Cross.Coordinate = (6, 5)
    
    @IBAction func goUp(_ sender: UIButton) {
        if coordinate == (goalCoordinate.x, goalCoordinate.y - 1) {
            crossNavigationController?.moveViewController(GoalViewController.create(), direction: .up, animated: true)
        } else {
            crossNavigationController?.moveViewController(ViewController.create(), direction: .up, animated: true)
        }
    }
    @IBAction func goRight(_ sender: UIButton) {
        if coordinate == (goalCoordinate.x - 1, goalCoordinate.y) {
            crossNavigationController?.moveViewController(GoalViewController.create(), direction: .right, animated: true)
        } else {
            crossNavigationController?.moveViewController(ViewController.create(), direction: .right, animated: true)
        }
    }
    @IBAction func goDown(_ sender: UIButton) {
        if coordinate == (goalCoordinate.x, goalCoordinate.y + 1) {
            crossNavigationController?.moveViewController(GoalViewController.create(), direction: .down, animated: true)
        } else {
            crossNavigationController?.moveViewController(ViewController.create(), direction: .down, animated: true)
        }
    }
    @IBAction func goLeft(_ sender: UIButton) {
        if coordinate == (goalCoordinate.x + 1, goalCoordinate.y) {
            crossNavigationController?.moveViewController(GoalViewController.create(), direction: .left, animated: true)
        } else {
            crossNavigationController?.moveViewController(ViewController.create(), direction: .left, animated: true)
        }
    }
    
    class func create() -> ViewController {
        let controller = UIStoryboard.main.instantiateViewController(withIdentifier: "Scene") as! ViewController
        return controller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = "x: \(coordinate.x) y: \(coordinate.y)"
    }
}
