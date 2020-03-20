//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by box-jeon-mac-mini on 2020/03/06.
//  Copyright © 2020 utrpanic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var score: Int = 0
    @State private var showingScore: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var degrees: [Double] = [0, 0, 0]
    @State private var opacities: [Double] = [1, 1, 1]
    @State private var scales: [CGFloat] = [1, 1, 1]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top,
                endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .fontWeight(.black)
                        .modifier(Title())
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(imageName: self.countries[number].lowercased())
                            .rotation3DEffect(.degrees(self.degrees[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(self.opacities[number])
                            .scaleEffect(self.scales[number])
                    }
                }
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == self.correctAnswer {
            withAnimation {
                for index in 0 ..< self.degrees.count {
                    self.degrees[index] = index == number ? 360 : 0
                }
                for index in 0 ..< self.opacities.count {
                    self.opacities[index] = index == number ? 1 : 0.25
                }
            }
        } else {
            withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)) {
                for index in 0 ..< self.scales.count {
                    self.scales[index] = index == number ? 0.8 : 1
                }
            }
        }
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 1
            alertMessage = "Your score is \(score)"
        } else {
            alertTitle = "Wrong"
            alertMessage = "That's the flag of \(self.countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        degrees = [0, 0, 0]
        opacities = [1, 1, 1]
        scales = [1, 1, 1]
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Title: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
    }
}

struct FlagImage: View {
    
    var imageName: String
    
    var body: some View {
        return Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
