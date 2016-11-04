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
    override var title: String? {
        set { label.text = newValue }
        get { return label.text }
    }
    class func create() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Scene") as! ViewController
        return controller
    }
    @IBAction func goUp(_ sender: UIButton) {
        move(.up)
    }
    @IBAction func goRight(_ sender: UIButton) {
        move(.right)
    }
    @IBAction func goDown(_ sender: UIButton) {
        move(.down)
    }
    @IBAction func goLeft(_ sender: UIButton) {
        move(.left)
    }
    
    func move(_ direction: Cross.Direction) {
        let crossNavigationcontroller = navigationController as? NavigationController
        guard let goalBefore: Cross.Coordinate = crossNavigationcontroller?.goalCoordinate else {
            crossNavigationcontroller?.moveViewController(ViewController.create(), direction: direction, animated: true)
            return
        }
        switch direction {
        case .up where coordinate == (goalBefore.x, goalBefore.y - 1),
             .right where coordinate == (goalBefore.x - 1, goalBefore.y),
             .down where coordinate == (goalBefore.x, goalBefore.y + 1),
             .left where coordinate == (goalBefore.x + 1, goalBefore.y):
            crossNavigationcontroller?.moveViewController(GoalViewController.create(), direction: direction, animated: true)
        default:
            crossNavigationcontroller?.moveViewController(ViewController.create(), direction: direction, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "x: \(coordinate.x) y: \(coordinate.y)"
    }
}

final class StartViewController: ViewController {
    //
}

final class GoalViewController: ViewController {
    override class func create() -> GoalViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Goal") as! GoalViewController
        return controller
    }
    @IBAction func goRoot(_ sender: UIButton) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
