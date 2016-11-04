//
//  CrossPanGestureRecognizer.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/08.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

final class CrossPanGestureRecognizer: UIPanGestureRecognizer {
    var direction: Cross.Direction = .right
    private var isMoved: Bool = false
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        guard !state.isFailed else { return }
        let velocityInView = self.velocity(in: view)
        if !isMoved && !velocityInView.equalTo(.zero) && Cross.Direction.panDirection(velocityInView) != direction {
            state = .failed
        }
        isMoved = true
    }
    override func reset() {
        super.reset()
        isMoved = false
    }
}

// MARK: - Extension
private extension Cross.Direction {
    static func panDirection(_ velocity: CGPoint) -> Cross.Direction? {
        let velocities: [Cross.Direction: CGFloat] = [
            .right: -velocity.x,
            .down:  -velocity.y,
            .left:  velocity.x,
            .up:    velocity.y
        ]
        return velocities.sorted { $0.1 < $1.1 }.last?.0
    }
}

// MARK: - Extension
private extension UIGestureRecognizerState {
    var isFailed: Bool {
        return self == .failed
    }
}
