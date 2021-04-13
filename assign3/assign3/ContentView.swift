//
//  ContentView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    
    var testScores: [Score] = [
        Score(score: 300, time: Date()),
        Score(score: 250, time: Date()),
        Score(score: 200, time: Date()),
        Score(score: 180, time: Date())
    ]
    
    var body: some View {
        
        TabView {
            MainView().tabItem {
                Label("Board", systemImage: "gamecontroller")
            }
            HighScoresView(scores: testScores).tabItem {
                Label("Scores", systemImage: "list.dash")
            }
            Text("About").tabItem {
                Label("About", systemImage: "info.circle")
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

struct MainView: View {
    
    @ObservedObject var game: Triples = Triples()
    @State var selectedGameMode: String = "Determ"
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ZStack {
            if verticalSizeClass == .regular {
                VStack {
                    Spacer(minLength: 10)
                    ScoreView(score: game.score)
                    
                    GameBoard(board: game.board, tileSize: 80)
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
                    
                    NavButtonsView(game: game, gameOverView: game.isDone, buttonWidth: 100, buttonHeight: 50)
                    
                    Spacer(minLength: 20)
                    
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
                        .frame(width: 320)
                        .padding(.bottom, 30)

                }
            } else {
                
                VStack {
                    Spacer(minLength: 10)
                    ScoreView(score: game.score)
                    
                    HStack {
                        Spacer()
                        VStack {
                            
                            GameBoard(board: game.board, tileSize: 60)
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
                        }
                        
                        Spacer(minLength: 10)
                        
                        VStack {
                            Spacer()
                            NavButtonsView(game: game, gameOverView: game.isDone, buttonWidth: 80, buttonHeight: 40)
                            
                            Spacer()
                            
                            Button(action: {
                                game.setIsDone(true)
                            }, label: {
                                Text("New Game")
                                    .frame(width: 150, height: 40)
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
                                .frame(width: 180)
                                .padding(.bottom, 30)
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
            }
            
            
            if game.isDone {
                GameOverView(game: game, selectedGameMode: selectedGameMode)
            }
        }
    }
}

struct HighScoresView: View {
    var scores: [Score]
    let dateFormatter = DateFormatter()
    
    init(scores: [Score]) {
        self.scores = scores
        createDateFormatter()
    }
    func createDateFormatter() {
        dateFormatter.dateFormat = "HH:mm:ss, d MMM y"
    }
    
    var body: some View {
        VStack {
            Text("Highest Scores")
                .bold()
                .font(.title)
            
            List {
                ForEach(scores) { score in
                    HStack {
                        Text("\(score.score)")
                        Spacer()
                        Text("\(dateFormatter.string(from: score.time))")
                    }
                }
            }
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

//tiles[i][j]
//        .offset(x: currentX[i][j], y: currentY[i][j])
//        .animation(game.animate ? .easeInOut(duration: 1) : .none)

struct GameBoard: View {
    
    var board: [[Tile]]
    var tileSize: CGFloat
    
    var body: some View {
        VStack{
            ForEach(board, id:\.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id:\.self) { tile in
                        TileView(tile: tile, tileSize: tileSize)
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
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    
    var body: some View {
        Text(text)
            .frame(width: buttonWidth, height: buttonHeight)
            .font(.system(size: 20, weight: .bold))
            .border(Color.gray, width: 5)
            .cornerRadius(10)
    }
}

struct NavButtonsView: View {
    var game: Triples
    var gameOverView: Bool
    
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    
    func up() { game.collapse(dir: .up) }
    func down() { game.collapse(dir: .down) }
    func left() { game.collapse(dir: .left) }
    func right() { game.collapse(dir: .right) }
    
    var body: some View {
        VStack(spacing: 5) {
            Button (action: withAnimation { up }) {
                NavButtonText(text: "Up", buttonWidth: buttonWidth, buttonHeight: buttonHeight)
            }.disabled(gameOverView)
            HStack(spacing: 20) {
                Button (action: withAnimation { left }) {
                    NavButtonText(text: "Left", buttonWidth: buttonWidth, buttonHeight: buttonHeight)
                }.disabled(gameOverView)
                
                Button (action: withAnimation { right }) {
                    NavButtonText(text: "Right", buttonWidth: buttonWidth, buttonHeight: buttonHeight)
                }.disabled(gameOverView)
            }
            Button (action: withAnimation { down }) {
                NavButtonText(text: "Down", buttonWidth: buttonWidth, buttonHeight: buttonHeight)
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
