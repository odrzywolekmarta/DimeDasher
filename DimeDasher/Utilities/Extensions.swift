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
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            let dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            return calender.date(from: dateComponents)
        }
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        return formatter.string(from: self)
    }
    
    func toStringLong() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
    
    func labelText() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: self)
    }
    
    func shortWeekDay() -> String {
        self.formatted(Date.FormatStyle().weekday(.abbreviated))
    }
    
    func shortMonth() -> String {
        self.formatted(Date.FormatStyle().month(.abbreviated))
    }
    
    func year() -> String {
        self.formatted(Date.FormatStyle().year())
    }
    
    func day() -> String {
        self.formatted(Date.FormatStyle().day())
    }
    
    func dayBefore() -> Date? {
        let components = Calendar.current.dateComponents([.day], from: self)
        if let nextDate = Calendar.current.nextDate(after: self, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .backward) {
            return nextDate
        } else {
            return nil
        }
    }
    
    func dayAfter() -> Date? {
        let components = Calendar.current.dateComponents([.day], from: self)
        if let nextDate = Calendar.current.nextDate(after: self, matching: components, matchingPolicy: .nextTime, repeatedTimePolicy: .first, direction: .forward){
            return nextDate
        } else {
            return nil
        }
    }
    
    func previousWeek() -> Date? {
       Calendar.current.date(byAdding: .weekOfYear, value: -1, to: self)
    }
    
    func nextWeek() -> Date? {
        Calendar.current.date(byAdding: .weekOfYear, value: 1, to: self)
    }

    func previousMonth() -> Date? {
        Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func nextMonth() -> Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func previousYear() -> Date? {
        Calendar.current.date(byAdding: .year, value: 1, to: self)
    }
    
    func nextYear() -> Date? {
        Calendar.current.date(byAdding: .year, value: -1, to: self)
    }
    
    func getDaysInMonth() -> Int {
        let calendar = Calendar.current

        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        var numDays = 0
        if let date = calendar.date(from: dateComponents) {
            let range = calendar.range(of: .day, in: .month, for: date)
            numDays = range?.count ?? 0
        }
        return numDays
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

//MARK: - Calendar
extension Calendar {
    typealias WeekBoundary = (startOfWeek: Date?, endOfWeek: Date?)
    
    func currentWeekBoundary() -> WeekBoundary? {
        return weekBoundary(for: Date())
    }
    
    func weekBoundary(for date: Date) -> WeekBoundary? {
        let components = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        guard let startOfWeek = self.date(from: components) else {
            return nil
        }
        
        let endOfWeekOffset = weekdaySymbols.count - 1
        let endOfWeekComponents = DateComponents(day: endOfWeekOffset, hour: 23, minute: 59, second: 59)
        
        guard let endOfWeek = self.date(byAdding: endOfWeekComponents, to: startOfWeek) else {
            return nil
        }
        
        return (startOfWeek, endOfWeek)
    }
}

//MARK: - Double
extension Double {
    func stringWithTwoDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(floatLiteral: self)) ?? ""
    }
    
    func moneyValue() -> String {
        var amountString = String(self.stringWithTwoDecimal())
        return amountString.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
    }
}

//MARK: - Int
extension Int {
    func isEven() -> Bool {
        if self % 2 == 0 {
            return true
        } else {
            return false
        }
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
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

//MARK: - Binding String
extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
