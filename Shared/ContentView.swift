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
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson : Double{
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelect = Double(tipPercentage)
        
        let tipAmount = checkAmount / 100 * tipSelect
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
                .navigationTitle("SplitCheck")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
