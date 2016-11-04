//
//  GestureViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/08.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit
import CrossNavigationController

final class GestureViewController: CrossViewController, CrossGestureControllable {

    @IBOutlet var upButton :UIButton!
    @IBOutlet var rightButton :UIButton!
    @IBOutlet var downButton :UIButton!
    @IBOutlet var leftButton :UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func goRoot(_ sender: UIButton) {
        _ = crossNavigationController?.moveToRootViewController(animated: true)
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
    
    var upViewContoller: CrossViewController? {
        didSet {
            addGestureRecognizer(.up)
        }
    }
    var rightViewContoller: CrossViewController? {
        didSet {
            addGestureRecognizer(.right)
        }
    }
    var downViewContoller: CrossViewController? {
        didSet {
            addGestureRecognizer(.down)
        }
    }
    var leftViewContoller: CrossViewController? {
        didSet {
            addGestureRecognizer(.left)
        }
    }
    
    static func create() -> GestureViewController {
        let controller = UIStoryboard.main.instantiateViewController(withIdentifier: "GestureScene") as! GestureViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        upViewContoller = GestureViewController.create()
        rightViewContoller = GestureViewController.create()
        downViewContoller = GestureViewController.create()
        leftViewContoller = GestureViewController.create()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = "x: \(coordinate.x) y: \(coordinate.y)"
    }

}
