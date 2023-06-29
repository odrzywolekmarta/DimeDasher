//
//  FirstLaunchViewModel.swift
//  DimeDasher
//
//  Created by Majka on 28/06/2023.
//

import Foundation
import Collections

@MainActor final class FirstLaunchViewModel: ObservableObject {
    var currencies: OrderedDictionary = ["USD": "en_US", "EUR": "fr_FR", "GBP": "en_GB", "PLN": "pl"]
    
    func saveDefaults(name: String, balance: Double, currency: String) {
        UserDefaults.standard.set(false, forKey: "showOnboarding")
        UserDefaults.standard.set(name, forKey: "username")
        UserDefaults.standard.set(balance, forKey: "startingBalance")
        UserDefaults.standard.set(currency, forKey: "currency")
    }
}
