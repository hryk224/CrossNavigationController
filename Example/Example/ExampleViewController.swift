//
//  ExampleViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/09.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit
import CrossNavigationController

final class ExampleViewController: CrossViewController, CrossGestureControllable {
    
    private var page: Int {
        return (navigationController?.viewControllers.count ?? 1) - 1
    }
    
    private var filePath: String? {
        return Bundle.main.path(forResource: "Example", ofType: "plist")
    }
    
    private var qs: [Any]? {
        guard let filePath = filePath else { return nil }
        return (NSArray(contentsOfFile: filePath) as? [Any])
    }
    
    private var q: [String: Any]? {
        return qs?[safe: page] as? [String: Any]
    }
    
    private var quention: String? {
        return q?["Question"] as? String
    }
    
    private var correct: String? {
        return q?["Correct"] as? String
    }
    
    private var correctDirection: Cross.Direction? {
        guard let correct = correct else { return nil }
        switch correct {
        case "up":
            return .up
        case "right":
            return .right
        case "down":
            return .down
        case "left":
            return .left
        default:
            return nil
        }
    }
    
    private var upA: String? {
        return q?["Up"] as? String
    }

    private var rightA: String? {
        return q?["Right"] as? String
    }

    private var downA: String? {
        return q?["Down"] as? String
    }
    
    private var leftA: String? {
        return q?["Left"] as? String
    }

    private var prevCorrect: String? {
        return (qs?[safe: page - 1] as? [String: Any])?["Correct"] as? String
    }
    
    private var noBackDirection: Cross.Direction? {
        guard let prevCorrect = prevCorrect else { return nil }
        switch prevCorrect {
        case "up":
            return .up
        case "right":
            return .right
        case "down":
            return .down
        case "left":
            return .left
        default:
            return nil
        }
    }
    
    @IBOutlet var upButton :UIButton! {
        didSet {
            upButton.setTitleColor(.gray, for: .normal)
            upButton.layer.borderWidth = 1
            upButton.layer.borderColor = UIColor.gray.cgColor
            upButton.isHidden = true
        }
    }
    @IBOutlet var rightButton :UIButton! {
        didSet {
            rightButton.setTitleColor(.gray, for: .normal)
            rightButton.layer.borderWidth = 1
            rightButton.layer.borderColor = UIColor.gray.cgColor
            rightButton.isHidden = true
        }
    }
    @IBOutlet var downButton :UIButton! {
        didSet {
            downButton.setTitleColor(.gray, for: .normal)
            downButton.layer.borderWidth = 1
            downButton.layer.borderColor = UIColor.gray.cgColor
            downButton.isHidden = true
        }
    }
    @IBOutlet var leftButton :UIButton! {
        didSet {
            leftButton.setTitleColor(.gray, for: .normal)
            leftButton.layer.borderWidth = 1
            leftButton.layer.borderColor = UIColor.gray.cgColor
            leftButton.isHidden = true
        }
    }
    @IBOutlet weak var qLabel: UILabel!
    
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
        willSet {
            guard let _ = newValue else { return }
            upButton.isHidden = false
        }
    }
    var rightViewContoller: CrossViewController? {
        willSet {
            guard let _ = newValue else { return }
            rightButton.isHidden = false
        }
    }
    var downViewContoller: CrossViewController? {
        willSet {
            guard let _ = newValue else { return }
            downButton.isHidden = false
        }
    }
    var leftViewContoller: CrossViewController? {
        willSet {
            guard let _ = newValue else { return }
            leftButton.isHidden = false
        }
    }
    
    static func create() -> ExampleViewController {
        let controller = UIStoryboard.example.instantiateViewController(withIdentifier: "ExampleScene") as! ExampleViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qLabel.text = quention
        
        upButton.setTitle(upA, for: .normal)
        rightButton.setTitle(rightA, for: .normal)
        downButton.setTitle(downA, for: .normal)
        leftButton.setTitle(leftA, for: .normal)
        
        leftViewContoller = ExampleViewController.create()
        rightViewContoller = ExampleViewController.create()
        downViewContoller = ExampleViewController.create()
        upViewContoller = ExampleViewController.create()
    }
    
}


// MARK: - Private Extension
private extension Collection {
    subscript(safe index: Index) -> _Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
