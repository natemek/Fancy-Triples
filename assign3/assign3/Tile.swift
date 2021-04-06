//
//  Tile.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/6/21.
//

import Foundation

public struct Tile: Identifiable, Hashable {
    var val : Int
    public var id = UUID()
    var row: Int    // recommended
    var col: Int    // recommended
}

