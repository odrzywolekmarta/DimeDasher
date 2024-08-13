//
//  FirstLaunchView.swift
//  DimeDasher
//
//  Created by Majka on 28/06/2023.
//

import SwiftUI
import OrderedCollections

struct FirstLaunchView: View {
    @StateObject private var viewModel = FirstLaunchViewModel()
    @State private var name: String = ""
    @State private var startingBalance: String = ""
    @State private var chosenCurrency: String = "USD"
    private var chosenLocale: String = ""
        
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = chosenCurrency
        return formatter
    }
    
    var body: some View {
        ZStack {
            Color(Constants.Colors.lightPink)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image(Constants.launchImage)
                Text(Constants.firstLaunchHeader)
                    .font(.custom(Constants.Fonts.ralewayBold, size: 40))
                
                TextField(Constants.firstLaunchName, text: $name.max(15))
                    .padding()
                    .font(.custom(Constants.Fonts.raleway, size: 20))
                    .background(
                        Color(Constants.Colors.beige)
                            .cornerRadius(10))
                    .padding()
                
                TextField(Constants.firstLaunchBalance, text: $startingBalance)
                    .onChange(of: startingBalance) { newValue in
                        if newValue.contains(".") {
                            var splitted = newValue.split(separator: ".")
                            if splitted.count >= 2 {
                                if splitted[1].count > 2 {
                                    splitted[1] = splitted[1].prefix(2)
                                }
                                startingBalance = "\(splitted[0]).\(splitted[1])"
                            }
                        }
                    }
                    .keyboardType(.decimalPad)
                    .padding()
                    .font(.custom(Constants.Fonts.raleway, size: 20))
                    .background(
                        Color(Constants.Colors.beige)
                            .cornerRadius(10))
                    .padding()
                
                Picker(selection: $chosenCurrency) {
                    ForEach(Constants.currencies.keys, id: \.self) { key in
                        Text("\(key)")
                    }
                } label: {
                    //
                } // picker
                .background(
                    Color(Constants.Colors.beige)             .cornerRadius(10))
                .tint(.black)
                .padding()
                
                Button {
                    viewModel.saveDefaults(name: name, balance: Double(startingBalance) ?? 0, currency: chosenCurrency)
                } label: {
                    Text(Constants.start)
                        .font(.custom(Constants.Fonts.raleway, size: 20))
                }
                .tint(Color(Constants.Colors.darkPink))
                .background(
                    Color(self.startingBalance == "" ? Constants.Colors.lightPink : Constants.Colors.mediumPink)
                        .cornerRadius(10)
                )
                .buttonStyle(.borderedProminent)
                .disabled(self.startingBalance == "")
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
