//
//  Extensions.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//

import Foundation
import SwiftUI

//MARK: - Date

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        return formatter.string(from: self)
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}

//MARK: - Double
extension Double {
    func stringWithTwoDecimal() -> String {
        let formatter = NumberFormatter()
        //        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(floatLiteral: self)) ?? ""
    }
    
    func moneyValue() -> String {
        var amountString = String(self.stringWithTwoDecimal())
        return amountString.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
    }
}
//MARK: - String
extension String {
    mutating func stringWithCurrencySymbol(currency: String) -> String {
        switch currency {
        case "USD": self.insert(contentsOf: "$", at: self.startIndex)
        case "GBP": self.insert(contentsOf: "£", at: self.startIndex)
        case "EUR": self.insert(contentsOf: "€", at: self.startIndex)
        case "PLN": self.insert(contentsOf: " zł", at: self.endIndex)
        default:  self.insert(contentsOf: "", at: self.endIndex)
        }
        return self
    }
}

//MARK: - View
extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    func hidden(_ shouldHide: Bool) -> some View {
           opacity(shouldHide ? 0 : 1)
       }
}
