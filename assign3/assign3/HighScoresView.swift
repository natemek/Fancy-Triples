//
//  HighScoresView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/13/21.
//

import SwiftUI

struct HighScoresView: View {
    var scores: [Score]
    let dateFormatter = DateFormatter()
    
    @State var testScores: [Score] = [
        Score(score: 300, time: Date()),
        Score(score: 200, time: Date()),
        Score(score: 250, time: Date()),
        Score(score: 180, time: Date())
    ]
    
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
