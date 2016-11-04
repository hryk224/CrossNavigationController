//
//  CrossNavigationController.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit

open class CrossNavigationController: UINavigationController {
    fileprivate enum Swipe {
        case changed, ended
        var isChanged: Bool { return self == .changed }
    }
    fileprivate var manager: Cross?
    
    // Required setup
    open func configure(manager: Cross?) {
        let rootCoordinate: Cross.Coordinate = manager?.rootCoordinate ?? (0, 0)
        (topViewController as? CrossViewController)?.coordinate = rootCoordinate
        self.manager = manager
        self.manager?.append(coordinate: rootCoordinate)
    }
    
    // Life cycle
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = self
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate = nil
    }
    
    // Push / Pop
    open func moveViewController(_ viewController: CrossViewController, direction : Cross.Direction, animated: Bool) {
        guard var newCoordinate = manager?.latestCoordinate else {
            super.pushViewController(viewController, animated: animated)
            return
        }
        switch direction {
        case .up:
            newCoordinate.y += 1
        case .down:
            newCoordinate.y -= 1
        case .right:
            newCoordinate.x += 1
        case .left:
            newCoordinate.x -= 1
        }
        if let index = manager?.index(of: newCoordinate) {
            _ = popToViewController(viewControllers[index], animated: animated)
        } else {
            viewController.coordinate = newCoordinate
            manager?.append(coordinate: newCoordinate)
            super.pushViewController(viewController, animated: animated)
        }
    }
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let viewController = viewController as? CrossViewController else {
            fatalError("Can not be used this class. Need to use the inherits from CrossViewController")
        }
        moveViewController(viewController, direction: .right, animated: animated)
    }
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        manager?.remove(range: 1...viewControllers.count - 1)
        return super.popToRootViewController(animated: animated)
    }
    open override func popViewController(animated: Bool) -> UIViewController? {
        guard let manager = manager, let index = manager.index(of: manager.popCoordinate) else {
            return nil
        }
        _ = popToViewController(viewControllers[index], animated: animated)
        return nil
    }
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let index = viewControllers.index(of: viewController) else {
            return nil
        }
        let startIndex = index + 1
        let endIndex = viewControllers.count - 1
        if endIndex >= startIndex {
            manager?.remove(range: startIndex...endIndex)
        } else {
            manager?.remove(at: startIndex)
        }
        return super.popToViewController(viewController, animated: animated)
    }
}

// MARK: - UINavigationcontrollerDelegate
extension CrossNavigationController: UINavigationControllerDelegate {
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let _ = manager, let _ = fromVC as? CrossViewController, let _ = toVC as? CrossViewController else {
            return nil
        }
        return CrossTransitionAnimator(operation: operation)
    }
}
