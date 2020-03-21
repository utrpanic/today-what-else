//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by box-jeon on 2020/03/21.
//  Copyright © 2020 utrpanic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var active: Bool = false
    @State private var table = 1
    @State private var number = 1
    private let tables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private let numbers = ["5", "10", "20", "All"]
    @State private var questions: [Question] = []
    private var currentQuestion: Question { return self.questions[0] }
    @State private var answer: String = ""
    @State private var score: Int = 0
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            Group {
                if self.active {
                    Form {
                        Section(header: Text("Question")) {
                            Text(self.currentQuestion.question)
                                .font(.largeTitle)
                        }
                        Section(header: Text("Answer")) {
                            TextField("", text: self.$answer, onCommit: answered)
                                .keyboardType(.decimalPad)
                            
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: nextQuestion))
                    }
                } else {
                    Form {
                        Section(header: Text("Table")) {
                            Picker("Table", selection: $table) {
                                ForEach(0 ..< self.tables.count) {
                                    Text("\(self.tables[$0])")
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Section(header: Text("Number of Questions")) {
                            Picker("Number of Questions", selection: $number) {
                                ForEach(0 ..< self.numbers.count) {
                                    Text("\(self.numbers[$0])")
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Section {
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.start()
                                }) {
                                    Text("Start")
                                        .font(.largeTitle)
                                        .foregroundColor(.red)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.navigationBarTitle("Multi")
        }
    }
    
    func start() {
        self.questions.removeAll()
        self.answer = ""
        self.score = 0
        if let numberOfQuestions = Int(self.numbers[self.number]) {
            for _ in 0 ..< numberOfQuestions {
                let randomNumber = self.tables.randomElement()!
                self.questions.append(Question(table: self.tables[self.table], number: randomNumber))
            }
        } else {
            for number in self.tables {
                self.questions.append(Question(table: self.tables[self.table], number: number))
            }
        }
        self.active = true
    }
    
    func answered() {
        if self.currentQuestion.isCorrect(answer: self.answer) {
            self.score += 1
            self.alertTitle = "Correct"
            self.alertMessage = "You score is \(self.score)"
        } else {
            self.alertTitle = "Wrong"
            self.alertMessage = "You score is \(self.score)"
        }
        self.showingAlert = true
    }
    
    func nextQuestion() {
        self.questions.removeFirst()
        if self.questions.isEmpty {
            self.active = false
        } else {
            self.answer = ""
        }
    }
}

struct Question {
     
    let table: Int
    let number: Int
    
    var question: String {
        return "What is \(self.table) X \(self.number)"
    }
    
    func isCorrect(answer: String) -> Bool {
        guard let answer = Int(answer) else { return false }
        return answer == self.table * self.number
    }
}
































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
