//
//  GameBoardView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/13/21.
//

import SwiftUI

struct GameBoard: View {
    
    var board: [[Tile]]
    var game: Triples
    var tileSize: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.gray)
                .frame(width: (tileSize * 4) + 10, height: (tileSize * 4) + 10)
                .cornerRadius(10)
            
            ZStack {
                ForEach (game.flattenBoard(), id: \.id) { tile in
                    if tile.val == 0 {
                        TileView(tile: tile, tileSize: tileSize)
                            .offset(CGSize(width: Int(tileSize) * tile.col, height: Int(tileSize) * tile.row))
                    } else {
                        TileView(tile: tile, tileSize: tileSize)
                            .offset(CGSize(width: Int(tileSize) * tile.col, height: Int(tileSize) * tile.row))
                            .animation(.easeInOut(duration: 1))
                    }
                }
                .offset(CGSize(width: tileSize == 80 ? -120 : -90, height: tileSize == 80 ? -120 : -90))
            }
        }
        
    }
}

struct TileView: View {
    
    var tile: Tile
    var tileSize: CGFloat
    
    var body: some View {
        if tile.val == 0 {
            Text("")
                .frame(width: tileSize, height: tileSize)
                .border(Color.gray, width: 5)
                .background(Color.white)
        } else if tile.val == 1 {
            Text("\(tile.val)")
                .frame(width: tileSize, height: tileSize)
                .border(Color.gray, width: 5)
                .background(Color.blue)
        } else if tile.val == 2 {
            Text("\(tile.val)")
                .frame(width: tileSize, height: tileSize)
                .border(Color.gray, width: 5)
                .background(Color.red)
        } else {
            Text("\(tile.val)")
                .frame(width: tileSize, height: tileSize)
                .border(Color.gray, width: 5)
                .background(Color.yellow)
        }
        
    }
}
