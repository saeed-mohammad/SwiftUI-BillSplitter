//
//  ContentView.swift
//  WeSplit
//
//  Created by saeed shaikh on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeope = 2
    @State private var selectedPercentage = 0
    
    let tipPercentage = [0, 10, 15, 20, 25, 30]
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"
        return formatter
    }
    
    private func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func calculation() -> Double {
        guard numOfPeope > 0 else { return 0 }
        let finalAmount = checkAmount
        let tipAmount = checkAmount * (Double(selectedPercentage) / 100.0)
        let perPerson = (finalAmount+tipAmount) / Double(numOfPeope)
        return perPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                
                Section {
                    TextField("Amount", value: $checkAmount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numOfPeope){
                        ForEach(1...15, id: \.self){
                            Text("People \($0)")
                        }
                    }
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage", selection: $selectedPercentage){
                        ForEach(tipPercentage, id: \.self){percentage in
                            Text("\(percentage)%")
                        }
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                Section {
                    Text("Total Amount per Person: \(calculation(), specifier: "%.2f")")
                }
                
                
            }
//            .onTapGesture {
//                hideKeyboard() // Dismiss keyboard when tapping anywhere else
//            }
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    ContentView()
}
