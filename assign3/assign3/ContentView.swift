//
//  ContentView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var game: Triples = Triples()
    
    var body: some View {
        
        TabView {
            MainView(game: game).tabItem {
                Label("Board", systemImage: "gamecontroller")
            }
            HighScoresView(scores: game.highScores.sorted{$0.score > $1.score}).tabItem {
                Label("Scores", systemImage: "list.dash")
            }
            AboutView().tabItem {
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
    
    @ObservedObject var game: Triples
    @State var selectedGameMode: String = "Random"
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ZStack {
            if verticalSizeClass == .regular {
                VStack {
                    Spacer(minLength: 10)
                    ScoreView(score: game.score)
                    Spacer()
                    GameBoard(board: game.board, game: game, tileSize: 80)
                    
                    Spacer()
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
                            GameBoard(board: game.board, game: game, tileSize: 60)
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

struct ScoreView: View {
    
    var score: Int
    
    var body: some View {
        Text("Score: \(score)")
            .font(.title)
            .padding()
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
                Text("Score: \(game.score)").foregroundColor(.black)
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
