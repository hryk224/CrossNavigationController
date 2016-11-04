//
//  GoalViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/08.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit

final class GoalViewController: ViewController {
    override class func create() -> GoalViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: "GoalScene") as! GoalViewController
    }
    @IBAction func goRoot(_ sender: UIButton) {
        _ = crossNavigationController?.moveToRootViewController(animated: true)
    }
}
