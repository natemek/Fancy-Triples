//
//  model.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/6/21.
//

import Foundation

enum Direction: String {
    case up
    case down
    case left
    case right
}

struct SeededGenerator: RandomNumberGenerator {
    let seed: UInt64
    var curr: UInt64
    init(seed: UInt64 = 0) {
        self.seed = seed
        curr = seed
    }
    
    mutating func next() -> UInt64  {
        curr = (103 &+ curr) &* 65537
        curr = (103 &+ curr) &* 65537
        curr = (103 &+ curr) &* 65537
        return curr
    }
}

// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2DInts(input: [[Int]]) -> [[Int]] {
    let N = input.count
    var output = input
    for x in 0...N-1 {
        for y in 0...N-1 {
            output[x][y] = input[N-1-y][x]
        }
    }
    
    return output
}

public func rotate2D<T>(input: [[T]]) -> [[T]] {
    let N = input.count
    var output = input
    for x in 0...N-1 {
        for y in 0...N-1 {
            output[x][y] = input[N-1-y][x]
        }
    }
    return output
}

public func collapsable(x: Int, y: Int) -> Bool {
    if (x != y) && (x >= 3 || y >= 3) && (x != 0) && (y != 0) { // x = 3, y = 1
        return false
    } else if (x == y) && (x < 3) { // x = 1, y = 1
        return false
    }
    return true
}
