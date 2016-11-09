//
//  StartViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/08.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit.UILabel

final class StartViewController: ViewController {
    @IBOutlet weak var startLabel: UILabel! {
        didSet {
            startLabel.layer.borderWidth = 1
            startLabel.layer.borderColor = startLabel.textColor.cgColor
        }
    }
}
