//
//  ContentView.swift
//  pig
//
//  Created by will lutz on 10/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var TurnScore = 0
    @State private var GameScore = 0
    @State private var randomValue = 0
    @State private var rotation = 0.0
    var body: some View {
        ZStack {
            Color.gray.opacity (0.7).ignoresSafeArea ()
            VStack {
                Image ("Pig").resizable ().frame(width: 150, height: 150)
                CustomText(text: "Pig")
                Image ("pips \(randomValue)")
                    .resizable()
                    .frame (width: 150, height: 150)
                    .rotationEffect(.degrees (rotation))
                    .rotation3DEffect(.degrees (rotation), axis: (x: 1, y: 1, z: 0))
                    . padding ()
                
                CustomText(text: "Turn Score:\(TurnScore)")
                HStack {
                    Button ("Roll") {
                        
                    }
                    .buttonStyle (CustomButtonStyle ())
                    Button ("Hold") {
                        
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                
                CustomText(text: "Turn Score: \(GameScore)")
                Spacer ()
            }
        }
    }
    func endTurn() {
        TurnScore = 0
        randomValue = 0
    }
    func chooseRandom (times: Int) {
        if times > 0 {
            DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
                randomValue = Int.random(in: 1...6)
                chooseRandom(times: times - 1)
            }
        }
        if times == 0 {
            if randomValue == 1 {
                DispatchQueue.main.asyncAfter (deadline: .now() + 1) {
                    endTurn()
                }
            }
            else {
                TurnScore += randomValue
            }
        }
    }
    
}

    struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom( "Marker Felt", size: 36))
    }
}
struct CustomButtonStyle: ButtonStyle {
    func makeBody (configuration: Configuration) -> some View {
        configuration.label
            .frame (width: 50) .font (Font.custom("Marker Felt", size: 24))
            .padding () .background(.red).opacity (configuration.isPressed ? 0.0: 1.0)
            .foregroundColor (.white)
            .clipShape (RoundedRectangle (cornerRadius: 10))
    }
}
