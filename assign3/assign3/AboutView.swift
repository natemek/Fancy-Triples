//
//  AboutView.swift
//  assign3
//
//  Created by Natnael Mekonnen on 4/13/21.
//

import SwiftUI

struct AboutView: View {
    @State var isAtMaxScale = false
    @State var x: CGFloat = CGFloat(Int.random(in: -250..<250))
    @State var y: CGFloat = CGFloat(Int.random(in: -350..<350))
    @State var caught: Bool = false
    
    @State var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    private var animation_ = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
    
    var body: some View {
        NavigationView {
            ZStack {
                Button(action: {
                    caught = true
                    timer.upstream.connect().cancel()
                }, label: {
                    Text("😎")
                        .onReceive(timer, perform: { _ in
                            self.isAtMaxScale.toggle()
                            x = CGFloat(Int.random(in: -350..<350))
                            y = CGFloat(Int.random(in: -450..<450))
                        })
                        .font(.system(size: 50))
                        .scaleEffect(isAtMaxScale ? 1 : 0.5)
                        .offset(x: x, y: y)
                        .animation(.easeInOut(duration: 1))
                        .onDisappear{
                            if !caught {
                                timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                            }
                        }
                }).disabled(caught)
                
                if caught {
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
                            Text("You Got Me!")
                            Text("🎉🎉🎉🎉")
                            Spacer()
                            Button(action: {
                                caught = false
                                timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.yellow)
                                        .frame(width: 110, height: 30)
                                    Text("Play Again🔁")
                                        .foregroundColor(.white)
                                }
                            })
                            Spacer()
                        }
                        .frame(width: 200, height: 180)
                    }
                }
            }
            .navigationBarTitle("Click Me If You Can💨", displayMode: .inline)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
