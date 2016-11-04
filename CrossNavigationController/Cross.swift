//
//  Cross.swift
//  CrossNavigationController
//
//  Created by yoshida hiroyuki on 2016/11/04.
//  Copyright © 2016年 hryk224. All rights reserved.
//

import Foundation

public struct Cross {
    public enum Direction {
        case up, right, down, left
    }
    public typealias Coordinate = (x: Int, y: Int)
    private var coordinates: [Coordinate] = []

    public init(rootCoordinate: Cross.Coordinate) {
        self.rootCoordinate = rootCoordinate
    }
    
    let rootCoordinate: Cross.Coordinate

    var latestCoordinate: Coordinate {
        return coordinates.last ?? rootCoordinate
    }
    var popCoordinate: Coordinate {
        return coordinates[safe: coordinates.count - 2] ?? rootCoordinate
    }
    mutating func append(coordinate: Coordinate) {
        coordinates.append(coordinate)
    }
    mutating func remove(range: CountableClosedRange<Int>) {
        coordinates[range] = []
    }
    mutating func remove(at index: Int) {
        guard coordinates.count > index else { return }
        coordinates.remove(at: index)
    }
    func index(of coordinate: Coordinate) -> Array<Coordinate>.Index? {
        return coordinates.index{ $0 == coordinate }
    }
}

// MARK: - Private Extension
private extension Collection {
    subscript(safe index: Index) -> _Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
