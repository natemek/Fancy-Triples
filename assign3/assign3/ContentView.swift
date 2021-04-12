//
//  ContentView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var game: Triples = Triples()
    @State var selectedGameMode: String = "Determ"
    
    var body: some View {
        ZStack {
            
            VStack {
                ScoreView(score: game.score)
                
                GameBoard(board: game.board)
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onEnded({ value in
                                if value.translation.width < 0 {
                                    game.collapse(dir: .left)
                                } else if value.translation.width > 0 {
                                    game.collapse(dir: .right)
                                } else if value.translation.height < 0 {
                                    game.collapse(dir: .up)
                                } else if value.translation.height > 0 {
                                    game.collapse(dir: .down)
                                }
                            })
                    )
                
                NavButtonsView(game: game, gameOverView: game.isDone)
                
                Spacer()
                
                Button(action: {
                    game.setIsDone(true)
                }, label: {
                    Text("New Game")
                        .frame(width: 200, height: 60)
                        .font(.system(size: 20, weight: .bold))
                        .border(Color.gray, width: 5)
                        .cornerRadius(10)
                }).disabled(game.isDone)
                
                Picker("GameMode", selection: $selectedGameMode) {
                    ForEach(["Random", "Determ"], id:\.self) {
                        mode in Text(mode)
                    }
                }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 320, height: 60)
                
                Spacer()
            }
            
            if game.isDone {
                GameOverView(game: game, selectedGameMode: selectedGameMode)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct ScoreView: View {
    
    var score: Int
    
    var body: some View {
        Text("Score: \(score)")
            .font(.title)
            .padding()
    }
}

struct TileView: View {
    
    var tile: Tile
    
    var body: some View {
        if tile.val == 0 {
            Text("")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.white)
        } else if tile.val == 1 {
            Text("\(tile.val)")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.blue)
        } else if tile.val == 2 {
            Text("\(tile.val)")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.red)
        } else {
            Text("\(tile.val)")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.yellow)
        }
        
    }
}

//tiles[i][j]
//        .offset(x: currentX[i][j], y: currentY[i][j])
//        .animation(game.animate ? .easeInOut(duration: 1) : .none)

struct GameBoard: View {
    
    var board: [[Tile]]
    
    var body: some View {
        VStack{
            ForEach(board, id:\.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id:\.self) { tile in
                        TileView(tile: tile)
                            .animation(.easeInOut(duration: 1))
                    }
                }
            }
        }
            .border(Color.gray, width: 10)
            .padding(.bottom, 20)
    }
}

struct NavButtonText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .frame(width: 100, height: 60)
            .font(.system(size: 20, weight: .bold))
            .border(Color.gray, width: 5)
            .cornerRadius(10)
    }
}

struct NavButtonsView: View {
    var game: Triples
    var gameOverView: Bool
    
    func up() { game.collapse(dir: .up) }
    func down() { game.collapse(dir: .down) }
    func left() { game.collapse(dir: .left) }
    func right() { game.collapse(dir: .right) }
    
    var body: some View {
        VStack(spacing: 10) {
            Button (action: withAnimation { up }) {
                NavButtonText(text: "Up")
            }.disabled(gameOverView)
            HStack(spacing: 20) {
                Button (action: withAnimation { left }) {
                    NavButtonText(text: "Left")
                }.disabled(gameOverView)
                
                Button (action: withAnimation { right }) {
                    NavButtonText(text: "Right")
                }.disabled(gameOverView)
            }
            Button (action: withAnimation { down }) {
                NavButtonText(text: "Down")
            }.disabled(gameOverView)
        }
    }
}

struct GameOverView: View {
    var game: Triples
    var selectedGameMode: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.white)
                .frame(width: 200, height: 180)
                .shadow(color: .black, radius: 30)
            
            VStack {
                Spacer()
                Text("😄")
                    .font(.system(size: 32))
                Spacer()
                Text("Score: \(game.score)")
                Spacer()
                Button(action: {
                    game.newgame(mode: selectedGameMode)
                    //                            gameOverView.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red)
                            .frame(width: 60, height: 30)
                        Text("Close")
                            .foregroundColor(.white)
                    }
                })
                Spacer()
            }
            .frame(width: 200, height: 180)
        }
    }
}
