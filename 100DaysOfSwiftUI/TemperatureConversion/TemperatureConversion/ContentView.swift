//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by box-jeon-mac-mini on 2020/03/05.
//  Copyright © 2020 utrpanic. All rights reserved.
//

import SwiftUI

enum Unit: Int, CaseIterable {
    
    case celsius
    case fahrenheit
    case kelvin
    
    var name: String {
        switch self {
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        case .kelvin: return "Kelvin"
        }
    }
}

struct ContentView: View {
    
    @State var number: String = ""
    @State var inputUnit: Int = Unit.celsius.rawValue
    @State var outputUnit: Int = Unit.fahrenheit.rawValue
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Input Number", text: $number)
                        .keyboardType(.decimalPad)
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< Unit.allCases.count) {
                            Text(Unit(rawValue: $0)!.name)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(0 ..< Unit.allCases.count) {
                            Text(Unit(rawValue: $0)!.name)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    HStack {
                        Text("Output Number")
                        Spacer()
                        Text(self.output())
                    }
                }
            }.navigationBarTitle("Temperature")
        }
    }
    
    private func output() -> String {
        guard let input = Double(self.number) else { return "" }
        let inputUnit = Unit(rawValue: self.inputUnit)!
        let outputUnit = Unit(rawValue: self.outputUnit)!
        let celsius = self.convertToCelsius(input, from: inputUnit)
        let target = self.convert(celsius, to: outputUnit)
        return "\(target)"
    }
    
    private func convertToCelsius(_ number: Double, from unit: Unit) -> Double {
        switch unit {
        case .celsius: return number
        case .fahrenheit: return (number - 32) / 9 * 5
        case .kelvin: return number - 273.15
        }
    }
    
    private func convert(_ celsius: Double, to unit: Unit) -> Double {
        switch unit {
        case .celsius: return celsius
        case .fahrenheit: return celsius * 9 / 5 + 32
        case .kelvin: return celsius + 273.15
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
