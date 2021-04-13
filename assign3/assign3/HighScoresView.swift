//
//  HighScoresView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/13/21.
//

import SwiftUI

struct HighScoresView: View {
    var scores: [Score]
//    var scores: [Score]
    let dateFormatter = DateFormatter()
    
    @State var testScores: [Score] = [
        Score(score: 300, time: Date()),
        Score(score: 200, time: Date()),
        Score(score: 250, time: Date()),
        Score(score: 180, time: Date())
    ]
    
    init(scores: [Score]) {
//        self.game = game
//        self.scores = game.highScores.sorted{$0.score > $1.score}
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
            
            List () {
                ForEach(0..<scores.count, id: \.self) { i in
                    HStack {
                        Text("\(i+1)")
                        Spacer()
                        Text("\(scores[i].score)")
                        Spacer()
                        Text("\(dateFormatter.string(from: scores[i].time))")
                    }
                }
            }
//            List () {
//                ForEach(0..<testScores.count, id: \.self) { i in
//                    HStack {
//                        Text("\(i+1)) \(testScores[i].score)")
//                        Spacer()
//                        Text("\(dateFormatter.string(from: testScores[i].time))")
//                    }
//                }
//            }
//            Button(action: {
//                testScores.append(Score(score: 55, time: Date()))
//                print(testScores)
//            }, label: {
//                Text("Button")
//            })
        }
    }
}

struct HighScoresView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoresView(scores: [
            Score(score: 300, time: Date()),
            Score(score: 200, time: Date()),
            Score(score: 250, time: Date()),
            Score(score: 180, time: Date())
        ])
    }
}
