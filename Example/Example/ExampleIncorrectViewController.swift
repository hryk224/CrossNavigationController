//
//  ExampleIncorrectViewController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/09.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit
import CrossNavigationController

final class ExampleIncorrectViewController: CrossViewController {
    static func create() -> ExampleIncorrectViewController {
        let controller = UIStoryboard.example.instantiateViewController(withIdentifier: "ExampleIncorrectScene") as! ExampleIncorrectViewController
        return controller
    }
}
