//
//  model.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/6/21.
//

import Foundation

class Triples: ObservableObject {
    @Published var board: [[Tile?]]
    @Published var score: Int
    var seededGenerator: SeededGenerator
    
    init() {
        board = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
        score = 0
        seededGenerator = SeededGenerator()
        newgame(mode: "Random")
    }
    
    func newgame(mode: String) {                   // re-inits 'board', and any other state you define
        if mode == "Determ" {
            seededGenerator = SeededGenerator(seed: 14)
        } else {
            seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        }
        board = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
        score = 0
        spawn()
        spawn()
        spawn()
        spawn()
    }
    
    func countEmpty() -> [Int: (Int, Int)] {
        var res = [Int: (Int, Int)]()
        var counter: Int = 0
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j] == 0 {
                    res[counter] = (i,j)
                    counter += 1
                }
            }
        }
        return res
    }
    
    func spawn() {
        let res = countEmpty()
//        print(res.sorted(by: { $0.0 < $1.0 }), res.keys.max()!)
        let val = Int.random(in: 1...2, using: &seededGenerator)
        let pos = Int.random(in: 0...res.keys.max()!, using: &seededGenerator)
        let (x, y) = res[pos]!
        board[x][y] = val
        score += val
    }
    
    func rotate() {                    // rotate a square 2D Int array clockwise
        board = rotate2DInts(input: board)
    }
    
    func shift() -> Bool {                     // collapse to the left
        let N = board.count
        var collapsed = false
        for x in 0...N-1 {
            var i: Int = 0
            while i < N-1 && !collapsable(x: board[x][i], y: board[x][i+1]) {
                i += 1
            }
            if i < N-1 {
                collapsed = true
                if board[x][i] == 0 || board[x][i+1] == 0 {
                    board[x][i] += board[x][i+1]
                } else {
                    board[x][i] += board[x][i+1]
                    score += board[x][i]
                }
                i += 1
                if i < N-1 {
                    for y in i...N-2 {
                        board[x][y] = board[x][y+1]
                    }
                }
                board[x][N-1] = 0
            }
        }
        return collapsed
    }
    
    func collapse(dir: Direction) {     // collapse in specified direction using shift() and rotate()
        var collapsed = false
        switch dir {
            case .left:
                collapsed = shift()
            case .right:
                rotate()
                rotate()
                collapsed = shift()
                rotate()
                rotate()
            case .up:
                rotate()
                rotate()
                rotate()
                collapsed = shift()
                rotate()
            case .down:
                rotate()
                collapsed = shift()
                rotate()
                rotate()
                rotate()
        }
        if collapsed {
            spawn()
        }
    }
}
