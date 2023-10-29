//
//  ContentView.swift
//  iConvert
//
//  Created by Ralph Aquino on 29/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var conversionInput = 0.0
    @State private var defaultUnit = "Meter"
    @State private var conversionUnit = "Meter"
    
    @FocusState var conversionInputIsFocused: Bool
    
    let units = ["Meters", "Kilometers", "Inches", "Feet", "Yards", "Miles"]
    
    // Base Unit is Meter. Create a variable that converts the selected unit to meter. then use it for conversion.
    
    var lengthInMeters: Double{
        switch defaultUnit{
        case "Kilometers":
            return conversionInput * 1000
        case "Inches":
            return conversionInput / 39.37
        case "Feet":
            return conversionInput / 3.284
        case "Yards":
            return conversionInput / 1.09361
        case "Miles":
            return conversionInput * 1609.34
        default:
            return conversionInput
        }
    }
    
    //Time to convert the Meter into the desired Unit
    var outputValue: Double{
        switch conversionUnit{
        case "Kilometers":
            return lengthInMeters / 1000
        case "Inches":
            return lengthInMeters * 39.37
        case "Feet":
            return lengthInMeters * 3.284
        case "Yards":
            return lengthInMeters * 1.09361
        case "Miles":
            return lengthInMeters / 1609.34
        default:
            return lengthInMeters

        }
    }
        
    var body: some View {
        NavigationStack{
            Form{
                Section("Convert From?"){
                    TextField("Convert from \(defaultUnit)", value: $conversionInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($conversionInputIsFocused)
                    Picker("Unit", selection: $defaultUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                    
                Section("Convert To?"){
                    Picker("Unit", selection: $conversionUnit){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    Section("Converted Value in \(conversionUnit)"){
                        Text(outputValue, format: .number)
                    }
                }

            }
            .navigationTitle("Go the Distance!")
            .toolbar{
                if conversionInputIsFocused{
                    Button("Done"){
                        conversionInputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
