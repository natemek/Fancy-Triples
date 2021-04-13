//
//  Score.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/12/21.
//

import Foundation

struct Score: Hashable, Identifiable {
    public var id = UUID()
    var score: Int
    var time: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
}
