//
//  CrossNavigationController.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit.UINavigationController

open class CrossNavigationController: UINavigationController {
    
    fileprivate typealias Coordinate = Cross.Coordinate
    
    fileprivate let animator = Cross.Animator()
    fileprivate var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    fileprivate var initialCoordinate: Cross.Coordinate = (0, 0)
    
    // Life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = self
    }
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate = nil
    }
    
    // Gesture
    dynamic func handlePanGesture(_ gestureRecognizer: CrossPanGestureRecognizer) {
        
        guard let gestureView = gestureRecognizer.view, let direction = gestureRecognizer.direction, let topViewController = topViewController as? CrossGestureControllable else { return }
        
        let nextViewController: CrossViewController?
        switch direction {
        case .up:
            nextViewController = topViewController.upViewContoller
        case .down:
            nextViewController = topViewController.downViewContoller
        case .right:
            nextViewController = topViewController.rightViewContoller
        case .left:
            nextViewController = topViewController.leftViewContoller
        }
        
        guard let viewController = nextViewController else { return }
        
        switch gestureRecognizer.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            interactiveTransition?.completionCurve = .easeOut
            moveViewController(viewController, direction: direction, animated: true)
        case .changed:
            var percent: CGFloat = 0
            switch direction {
            case .up, .down:
                percent = gestureRecognizer.translation(in: gestureView).y / gestureView.bounds.height
            case .right, .left:
                percent = gestureRecognizer.translation(in: gestureView).x / gestureView.bounds.width
            }
            percent = min(1, max(0, fabs(percent)))
            interactiveTransition?.update(percent)
        case .ended, .cancelled:
            let velocity: CGFloat
            switch direction {
            case .up, .down:
                velocity = gestureRecognizer.velocity(in: view).y
            case .right, .left:
                velocity = gestureRecognizer.velocity(in: view).x
            }
            if fabs(velocity) > 0 {
                interactiveTransition?.finish()
            } else {
                interactiveTransition?.cancel()
            }
            interactiveTransition = nil
        default:
            break
        }
        
    }
}

// MARK: - Extension Coordinate
extension CrossNavigationController {
    fileprivate var coordinates: [Coordinate] {
        return viewControllers.flatMap({ ($0 as? CrossViewController)?.coordinate })
    }
    fileprivate var latestCoordinate: Coordinate {
        return coordinates.last ?? initialCoordinate
    }
    private var popCoordinate: Coordinate {
        return coordinates[safe: coordinates.count - 2] ?? initialCoordinate
    }
    fileprivate var popIndex: Array<Coordinate>.Index? {
        return index(of: popCoordinate)
    }
    fileprivate func index(of coordinate: Coordinate) -> Array<Coordinate>.Index? {
        return coordinates.index{ $0 == coordinate }
    }
}

// MARK: - Extension
extension CrossNavigationController {
    // Required setup
    fileprivate func configure() {}
    open func setUp(initialCoordinate: Cross.Coordinate) {
        self.initialCoordinate = initialCoordinate
        (topViewController as? CrossViewController)?.position = initialCoordinate
    }
    open func moveViewController(_ viewController: CrossViewController, direction : Cross.Direction, animated: Bool) {
        var newCoordinate = latestCoordinate
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
        if let index = self.index(of: newCoordinate) {
            _ = moveToViewController(viewControllers[index], animated: animated)
        } else {
            viewController.position = newCoordinate
            super.pushViewController(viewController, animated: animated)
        }
    }
    open func moveToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }
    open func moveToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: animated)
    }
}

// MARK: - Push / Pop
extension CrossNavigationController {
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let viewController = viewController as? CrossViewController else {
            fatalError("Can not be used this class. Need to use the inherits from CrossViewController")
        }
        if viewControllers.isEmpty {
            super.pushViewController(viewController, animated: animated)
            return
        }
        // FIXME: ... crash
//        moveViewController(viewController, direction: direction, animated: animated)
    }
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return moveToRootViewController(animated: animated)
    }
    open override func popViewController(animated: Bool) -> UIViewController? {
        guard let index = popIndex else {
            return nil
        }
        _ = moveToViewController(viewControllers[index], animated: animated)
        return nil
    }
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return moveToViewController(viewController, animated: animated)
    }
}

// MARK: - UINavigationcontrollerDelegate
extension CrossNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let _ = fromVC as? CrossViewController, let _ = toVC as? CrossViewController else {
            return nil
        }
        animator.operation = operation
        return animator
    }
}

// MARK: - Private Extension
private extension Collection {
    subscript(safe index: Index) -> _Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
