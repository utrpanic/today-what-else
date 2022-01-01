//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by box-jeon-mac-mini on 2020/03/10.
//  Copyright © 2020 utrpanic. All rights reserved.
//

import SwiftUI

enum Move: String, CaseIterable, Identifiable {
    
    case rock
    case paper
    case scissors
    
    var id: Move {
        return self
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
    
    func wins(_ opposite: Move) -> Bool {
        switch self {
        case .rock: return opposite == .scissors
        case .paper: return opposite == .rock
        case .scissors: return opposite == .paper
        }
    }
}

struct ContentView: View {
    
    @State var choice: Int = Int.random(in: 0 ..< Move.allCases.count)
    var currentMove: Move { return Move.allCases[self.choice] }
    @State var shouldWin: Bool = Bool.random()
    @State var score: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Score: \(self.score)")
                .font(.largeTitle)
            Text("App picks \(self.currentMove.name)")
                .font(.title)
            if shouldWin {
                Text("Choose to Win.")
                    .font(.title)
            } else {
                Text("Choose to lose.")
                    .font(.title)
            }
            HStack(spacing: 20) {
                ForEach(Move.allCases) { userMove in
                    Button(action: {
                        self.moveTapped(userMove)
                    }) {
                        Text("\(userMove.name)")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private func moveTapped(_ userMove: Move) {
        let correct = userMove.wins(self.currentMove) == self.shouldWin
        self.score = self.score + (correct ? 1 : -1)
        self.choice = Int.random(in: 0 ..< Move.allCases.count)
        self.shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
