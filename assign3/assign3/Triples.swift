//
//  model.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/6/21.
//

import Foundation

class Triples: ObservableObject {
    @Published var board: [[Tile]]
    @Published var highScores: [Score] = [
        Score(score: 300, time: Date()),
        Score(score: 400, time: Date())
    ]
    @Published var score: Int
    @Published var isDone: Bool
    var seededGenerator: SeededGenerator
    
    init() {
        board = []
        score = 0
        isDone = false
        seededGenerator = SeededGenerator()
        newgame(mode: "Random")
    }
    
    // re-inits 'board', and any other state you define
    func newgame(mode: String) {
        if score != 0 {
            highScores.append(Score(score: self.score, time: Date()))
        }
        
        if mode == "Determ" {
            seededGenerator = SeededGenerator(seed: 14)
        } else {
            seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        }
        board = []
        for i in 0..<4 {
            var row: [Tile] = []
            for j in 0..<4 {
                let tile = Tile(val: 0, row: i, col: j)
                row.append(tile)
            }
            board.append(row)
        }
        score = 0
        isDone = false
        spawn()
        spawn()
        spawn()
        spawn()
    }
    
    func flattenBoard() -> [Tile] {
        var res: [Tile] = []
        for row in board {
            for tile in row {
                res.append(tile)
            }
        }
        return res
    }
    
    func countEmpty() -> [Int: (Int, Int)] {
        var res = [Int: (Int, Int)]()
        var counter: Int = 0
        for i in 0..<board.count {
            for j in 0..<board[i].count {
                if board[i][j].val == 0 {
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
        board[x][y] = Tile(val: val, row: x, col: y)
        score += val
    }
    
    // rotate a square 2D Int array clockwise
    func rotate() {
        board = rotate2D(input: board)
    }
    
    func isGameDone() -> Bool {
        let empty = countEmpty()
        
        // check empty spaces
        if empty.count == 0 {
            // check if collapsable
            for x in 0...board.count-1 {
                for i in 0...board.count-2 {
                    if collapsable(x: board[x][i].val, y: board[x][i+1].val) {
                        return false
                    }
                }
            }
            return true
        }
        
        return false
    }
    
    func setIsDone(_ newIsDone: Bool) {
        isDone = newIsDone
    }
    
    // collapse to the left
    func shift(shiftAxis: String, shiftDir: Int) -> Bool {
        let N = board.count
        var collapsed = false
        for x in 0...N-1 {
            var i: Int = 0
            while i < N-1 && !collapsable(x: board[x][i].val, y: board[x][i+1].val) {
                i += 1
            }
            if i < N-1 {
                collapsed = true
                if board[x][i].val == 0 || board[x][i+1].val == 0 {
                    if board[x][i].val != 0 {
                        // tile not shifted
                        board[x][i] = board[x][i]
                    } else {
                        board[x][i] = board[x][i+1]
                    }
                } else {
                    board[x][i+1].val += board[x][i].val
                    board[x][i+1].row = board[x][i].row
                    board[x][i+1].col = board[x][i].col
                    board[x][i] = board[x][i+1]
                    score += board[x][i].val
                }
                i += 1
                if i < N-1 {
                    for y in i...N-2 {
                        board[x][y] = board[x][y+1]
                    }
                }
                let rowForNew = board[x][N-2].row
                let colForNew = board[x][N-2].col + 1
                board[x][N-1] = Tile(val: 0, row: rowForNew, col: colForNew)
            }
        }
        return collapsed
    }

    
    func collapse(dir: Direction) {     // collapse in specified direction using shift() and rotate()
        var collapsed = false
        switch dir {
            case .left:
                collapsed = shift(shiftAxis: "x", shiftDir: -1)
            case .right:
                rotate()
                rotate()
                collapsed = shift(shiftAxis: "x", shiftDir: 1)
                rotate()
                rotate()
            case .up:
                rotate()
                rotate()
                rotate()
                collapsed = shift(shiftAxis: "y", shiftDir: 1)
                rotate()
            case .down:
                rotate()
                collapsed = shift(shiftAxis: "y", shiftDir: -1)
                rotate()
                rotate()
                rotate()
        }
        if collapsed {
            spawn()
        }
        // update row and col
        for i in 0..<4 {
            for j in 0..<4 {
                board[i][j].row = i
                board[i][j].col = j
            }
        }
        
        isDone = isGameDone()
//        printBoard()
    }
    
    func printBoard() {
        print("Board: ")
        for i in 0..<board.count {
            print("[", terminator:"")
            for j in 0..<board[i].count {
                let b = board[i][j]
                print("(val: \(b.val), row: \(b.row), col: \(b.col))", terminator:"")
            }
            print("]")
        }
    }
}
