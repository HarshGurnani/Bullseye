//
//  ContentView.swift
//  Shared
//
//  Created by Neelam Gurnani on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alertIsVisible: Bool = false
    @State private var sliderVar: Double = 50.0
    @State private var game: Game = Game()
    
    var body: some View {
        ZStack {
            // rgb(243, 248, 253)
            // swift wants us to put rgb values from 0 to 1
            BackgroundView(game: $game)
            VStack {
                InstructionsView(game: $game).padding(.bottom, alertIsVisible ? 0 : 100)
                if alertIsVisible {
                    PointsView(game: $game, alertIsVisible: $alertIsVisible, sliderVar: $sliderVar)
                        .transition(.scale)
                } else {
                    HitMeButton(game: $game, alertIsVisible: $alertIsVisible, sliderVar: $sliderVar)
                        .transition(.scale)
                }
            }
            if !alertIsVisible {
                SliderView(sliderVar: $sliderVar)
                    .transition(.scale)
            }
            
        }
    }
}

struct InstructionsView: View {
    @Binding var game: Game
    
    var body: some View {
        VStack {
            InstructionText(text: "🎯🎯🎯\nPUT THE BULLSEYE AS CLOSE AS YOU CAN TO")
                .padding(.leading, 30.0)
                .padding(.trailing, 30.0)
            
            BigNumberText(text: String(game.target))
        }
    }
}

struct SliderView: View {
    @Binding var sliderVar: Double
    
    var body: some View {
        HStack {
            SliderLabelText(text: "1")
            Slider(value: self.$sliderVar, in: 1.0...100.0)
            SliderLabelText(text: "100")
        }
        .padding()
    }
}

struct HitMeButton: View {
    @Binding var game: Game
    @Binding var alertIsVisible: Bool
    @Binding var sliderVar: Double
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.alertIsVisible = true
            }

        }) {
            Text("Hit Me".uppercased()).bold().font(.title3)
        }
        .padding(20.0)
        .background(
            ZStack {
                Color("ButtonColor")
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
            }
        )
        .foregroundColor(Color.white)
        .cornerRadius(21.0)
        .overlay(
            RoundedRectangle(cornerRadius: 21.0)
                .strokeBorder(Color.white, lineWidth: Constants.General.strokeWidth)
        )
        
        /*
        .alert(isPresented: $alertIsVisible, content: {
            var roundedValue: Int = Int(self.sliderVar.rounded())
            var points = self.game.points(sliderValue: roundedValue)
            return Alert(title: Text("Hello There!"), message: Text("The slider's value is \(roundedValue).\n You scored + \(points) points this round."), dismissButton: .default(Text("Awesome!")) {
                game.startNewRound(points: points)
            })
        })
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            
    }
}
