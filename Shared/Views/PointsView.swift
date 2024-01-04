//
//  PointsView.swift
//  Bullseye (iOS)
//
//  Created by Neelam Gurnani on 12/13/22.
//

import SwiftUI

struct PointsView: View {
    
    @Binding var game: Game
    @Binding var alertIsVisible: Bool
    @Binding var sliderVar: Double
    
    
    var body: some View {
        let roundedValue = Int(sliderVar.rounded())
        let points = game.points(sliderValue: roundedValue)
        
        VStack (spacing: 10){
            InstructionText(text: "THE SLIDERS VALUE IS")
            BigNumberText(text: String(roundedValue))
            BodyText(text: String(points))
            Button(action: {
                withAnimation {
                    alertIsVisible = false
                }
                game.startNewRound(points: points)
            }) {
                ButtonText(text: "Start New Round")
            }
            
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color("BackgroundColor"))
        .cornerRadius(21.0)
        .shadow(radius: 10, x: 5, y: 5)
        .transition(.scale)
    }
}

struct PointsView_Previews: PreviewProvider {
    static private var alertIsVisible = Binding.constant(false)
    static private var sliderValue = Binding.constant(50.0)
    static private var game = Binding.constant(Game())
    
    static var previews: some View {
        PointsView(game: game, alertIsVisible: alertIsVisible, sliderVar: sliderValue)
    }
}
