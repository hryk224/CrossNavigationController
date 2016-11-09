//
//  CrossControllerable.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/08.
//  Copyright © 2016年 hryk224. All rights reserved.
//

public protocol CrossControllable: class {
    var view: UIView! { set get }
    var navigationController: UINavigationController? { get }
    var crossNavigationController: CrossNavigationController? { get }
    var coordinate: Cross.Coordinate { get }
}

extension CrossControllable {
    var crossNavigationController: CrossNavigationController? {
        return navigationController as? CrossNavigationController
    }
}

public protocol CrossGestureControllable: CrossControllable {

    var upViewContoller: CrossViewController? { get set }
    var rightViewContoller: CrossViewController? { get set }
    var downViewContoller: CrossViewController? { get set }
    var leftViewContoller: CrossViewController? { get set }
    func move(_ direction: Cross.Direction)

    func addGestureRecognizer(_ direction: Cross.Direction)
    func removeGestureRecognizer(_ direction: Cross.Direction)
    func removeAllGestureRecognizers()
}

// MARK: - Extension
public extension CrossGestureControllable {
    func move(_ direction: Cross.Direction) {
        let crossViewController: CrossViewController?
        switch direction {
        case .up:
            crossViewController = upViewContoller
        case .right:
            crossViewController = rightViewContoller
        case .down:
            crossViewController = downViewContoller
        case .left:
            crossViewController = leftViewContoller
        }
        guard let viewController = crossViewController else { return }
        crossNavigationController?.moveViewController(viewController, direction: direction, animated: true)
    }
}

// MARK: - Extension
public extension CrossGestureControllable {
    func addGestureRecognizer(_ direction: Cross.Direction) {
        guard let crossNavigationController = crossNavigationController else { return }
        guard navigationController?.view.gestureRecognizers?.filter({ ($0 as? CrossPanGestureRecognizer)?.direction == direction }).count == 0 else { return }
        let panGesture = CrossPanGestureRecognizer()
        panGesture.addTarget(crossNavigationController, action: #selector(CrossNavigationController.handlePanGesture(_:)))
        panGesture.direction = direction
        navigationController?.view.addGestureRecognizer(panGesture)
    }
    func removeGestureRecognizer(_ direction: Cross.Direction) {
        navigationController?.view.gestureRecognizers?.filter({ ($0 as? CrossPanGestureRecognizer)?.direction == direction }).forEach { view.removeGestureRecognizer($0) }
    }
    func removeAllGestureRecognizers() {
        navigationController?.view.gestureRecognizers?.forEach { view.removeGestureRecognizer($0) }
    }
}
