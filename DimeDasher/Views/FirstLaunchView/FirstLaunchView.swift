//
//  FirstLaunchView.swift
//  DimeDasher
//
//  Created by Majka on 28/06/2023.
//

import SwiftUI
import CurrencyField

struct FirstLaunchView: View {
    @StateObject private var viewModel = FirstLaunchViewModel()
    @State private var name: String = ""
    @State private var startingBalance: Double?
    @State private var chosenCurrency: String = "USD"
    private let currencies = ["USD", "EUR", "GBP", "PLN"]
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = chosenCurrency
        return formatter
    }
    
    var body: some View {
        ZStack {
            Color(Constants.lightPink)
                .ignoresSafeArea()
            
            VStack() {
                Text("Hello!")
                    .font(.custom(Constants.ralewayBold, size: 40))
                
                TextField("Enter your name", text: $name)
                    .padding()
                    .font(.custom(Constants.raleway, size: 20))
                    .background(
                        Color(Constants.beige)
                            .cornerRadius(10))
                    .padding()
                
                TextField(value: $startingBalance, format: .number) {
                    Text("Enter starting balance")
                }
                .keyboardType(.decimalPad)
                .padding()
                .font(.custom(Constants.raleway, size: 20))
                .background(
                    Color(Constants.beige)
                        .cornerRadius(10))
                .padding()
                
                Picker(selection: $chosenCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text("\(currency)")
                    }
                } label: {
                    //
                } // picker
                .background(
                    Color(Constants.beige)             .cornerRadius(10))
                .tint(.black)
                .padding()
                
                Button {
                    viewModel.saveDefaults(name: name, balance: startingBalance ?? 0, currency: chosenCurrency)
                } label: {
                    Text("Start")
                        .font(.custom(Constants.raleway, size: 20))
                }
                .tint(Color(Constants.mediumPink))
                .buttonStyle(.borderedProminent)
                .padding()

            } // vstack
        } // zstack
        
    }
}

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}
