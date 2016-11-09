//
//  ExampleNavigationController.swift
//  Example
//
//  Created by yoshida hiroyuki on 2016/11/09.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit
import CrossNavigationController

final class ExampleNavigationController: CrossNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
}
