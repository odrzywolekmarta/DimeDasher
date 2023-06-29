//
//  MainViewModel.swift
//  DimeDasher
//
//  Created by Majka on 28/06/2023.
//

import Foundation

@MainActor final class MainViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var balance: String = ""
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    } ()
    
    init() {
        getUserDataFromDefaults()
        calculateBalance()
    }
    
    func getUserDataFromDefaults() {
        username = UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    func calculateBalance() {
        let startingBalance = currencyFormatter.string(from: NSNumber(floatLiteral: UserDefaults.standard.double(forKey: "startingBalance")))
//        let calculatedBalance = "" 
        balance = stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "", balance: startingBalance ?? "")
    }
    
    func stringWithCurrencySymbol(currency: String, balance: String) -> String {
        var transformedBalance = balance
        switch currency {
        case "USD": transformedBalance.insert(contentsOf: "$", at: transformedBalance.startIndex)
        case "GBP": transformedBalance.insert(contentsOf: "£", at: transformedBalance.startIndex)
        case "EUR": transformedBalance.insert(contentsOf: "€", at: transformedBalance.startIndex)
        case "PLN": transformedBalance.insert(contentsOf: " zł", at: transformedBalance.endIndex)
        default:  transformedBalance.insert(contentsOf: "", at: transformedBalance.endIndex)
        }
        return transformedBalance
    }
}

extension MainViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
        username = "John Doe"
        balance = "10000"
    }
}
