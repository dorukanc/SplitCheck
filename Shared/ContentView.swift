//
//  ContentView.swift
//  Shared
//
//  Created by Dorukan Çatak on 4.08.2022.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused : Bool
    
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency{ get{
        return .currency(code: Locale.current.currencyCode ?? "USD")
    } }
    
    var grandTotal : Double{
        let tipSelect = Double(tipPercentage)
        
        let tipAmount = checkAmount / 100 * tipSelect
        let grandTotal = checkAmount + tipAmount
        return grandTotal
    }
    var totalPerPerson : Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Check Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                }header: {
                    Text("How much tip would you like to give?")
                }
                Section{
                    Text(grandTotal, format: currencyFormat)
                }header: {
                    Text("Grand Total")
                }
                Section{
                    Text(totalPerPerson, format: currencyFormat)
                }header: {
                    Text("Total Per Person")
                }
                .navigationTitle("SplitCheck")
            }.toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isFocused = false
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
