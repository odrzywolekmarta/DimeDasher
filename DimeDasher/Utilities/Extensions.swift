//
//  Extensions.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//

import Foundation
import SwiftUI

extension Sequence where Iterator.Element == DateComponents {
    func dateArray() -> [Date] {
        var dateArray = [Date]()
        for element in self {
            if let date = NSCalendar.current.date(from: element) {
                dateArray.append(date)
            }
        }
        return dateArray
    }
}

//MARK: - Date
extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        return formatter.string(from: self)
    }
    
    var onlyDate: Date? {
        get { 
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
//            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
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
    
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
