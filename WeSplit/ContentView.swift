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
    @FocusState private var isFocused
    
//    let tipPercentage = [0, 10, 15, 20, 25, 30]
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"
        return formatter
    }
    
    //    private func hideKeyboard(){
    //        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    //    }
    
    var AmountPerPerson: Double{
        let finalAmount = checkAmount
        let tipAmount = checkAmount * (Double(selectedPercentage) / 100.0)
        let perPerson = (finalAmount+tipAmount) / Double(numOfPeope)
        return perPerson
    }
    var totalAmountAfterTip: Double{
        let finalAmount = checkAmount
        let tipAmount = checkAmount * (Double(selectedPercentage) / 100.0)
        return finalAmount + tipAmount
    }
    //    private func calculation() -> Double {
    //        guard numOfPeope > 0 else { return 0 }
    //        let finalAmount = checkAmount
    //        let tipAmount = checkAmount * (Double(selectedPercentage) / 100.0)
    //        let perPerson = (finalAmount+tipAmount) / Double(numOfPeope)
    //        return perPerson
    //    }
    
    var body: some View {
        NavigationStack{
            Form{
                
                Section {
                    TextField("Amount", value: $checkAmount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    if #available(iOS 17.0, *) {
                        Picker("Number of People", selection: $numOfPeope){
                            ForEach(1...15, id: \.self){
                                Text("People \($0)")
                            }
                        }.pickerStyle(.wheel)
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage", selection: $selectedPercentage){
                        //                        ForEach(tipPercentage, id: \.self){percentage in
                        //                            Text("\(percentage)%")
                        //                        }
                        ForEach(0...100, id: \.self){
                            Text("\($0)%")
                        }
                    }
                }
                //                .pickerStyle(.segmented)
                .pickerStyle(.navigationLink)
                
                Section ("Total Amount After Including Tip"){
                    Text("\(totalAmountAfterTip, specifier: "%.2f")")
                }
                Section ("Amount per person"){
                    //                    Text("Total Amount per Person: \(calculation(), specifier: "%.2f")")
                    Text("\(AmountPerPerson, specifier: "%.2f")")
                }
                
                
            }
//            .onTapGesture {
//                hideKeyboard() // Dismiss keyboard when tapping anywhere else
//            }
            .navigationTitle("WeSplit")
            .toolbar{
                if isFocused {
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
