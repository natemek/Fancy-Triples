//
//  NavButtonsView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/14/21.
//

import SwiftUI

struct NavButtonsView: View {
    var game: Triples
    var gameOverView: Bool
    @Binding var selectedGameMode: String
    
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
    }
}

struct NavButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavButtonsView(game: Triples(), gameOverView: false, selectedGameMode: .constant("Random"), buttonWidth: 100, buttonHeight: 50)
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
