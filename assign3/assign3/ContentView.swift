//
//  ContentView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 3/31/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var game: Triples = Triples()
    @State var selectedGameMode: String = "Random"
    
    var body: some View {
        VStack {
            ScoreView(score: game.score)
            
            GameBoard(board: game.board)
            
            NavButtonsView(game: game)
            
            Spacer()
            
            Button(action: {
                game.newgame(mode: selectedGameMode)
            }, label: {
                Text("New Game")
                    .frame(width: 200, height: 60)
                    .font(.system(size: 20, weight: .bold))
                    .border(Color.gray, width: 5)
                    .cornerRadius(10)
            })
            
            Picker("GameMode", selection: $selectedGameMode) {
                ForEach(["Random", "Determ"], id:\.self) {
                    mode in Text(mode)
                }
            }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 320, height: 60)
            
            Spacer()
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

struct BoxView: View {
    
    var num: Int
    
    var body: some View {
        if num == 0 {
            Text("")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.white)
        } else if num == 1 {
            Text("\(num)")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.blue)
        } else if num == 2 {
            Text("\(num)")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.red)
        } else {
            Text("\(num)")
                .frame(width: 80, height: 80)
                .border(Color.gray, width: 5)
                .background(Color.yellow)
        }
    }
}

struct GameBoard: View {
    
    var board: [[Int]]
    
    var body: some View {
        VStack{
            ForEach(board, id:\.self) {
                row in HStack(spacing: 0) {
                    ForEach(row, id:\.self) {
                        val in BoxView(num: val)
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
    
    var body: some View {
        VStack(spacing: 10) {
            Button (action: {
                game.collapse(dir: .up)
            }, label: {
                NavButtonText(text: "Up")
            })
            HStack(spacing: 20) {
                Button (action: {
                    game.collapse(dir: .left)
                }, label: {
                    NavButtonText(text: "Left")
                })
                
                Button (action: {
                    game.collapse(dir: .right)
                }, label: {
                    NavButtonText(text: "Right")
                })
            }
            Button (action: {
                game.collapse(dir: .down)
            }, label: {
                NavButtonText(text: "Down")
            })
        }
    }
}
