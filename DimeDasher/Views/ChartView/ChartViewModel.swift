//
//  ChartViewModel.swift
//  DimeDasher
//
//  Created by Majka on 05/08/2023.
//

import Foundation
import OrderedCollections

enum TimePeriodType: String, CaseIterable {
    case week
    case month
    case year
}

@MainActor final class ChartViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    private var expenses = [ExpenseModel]() // all expenses (fetch only one year?)
    var displayedDate: Date = Date()
    private var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }()
    
    @Published var filteredExpensesForPeriod = [ExpenseModel]() // for transactions list
    @Published var filteredExpensesForSelection = [ExpenseModel]() // for transactions list when bar selected on chart
    @Published var barExpenses = [ExpenseBarModel]() // for bar graph
    @Published var maxExpense: Int = 0
    @Published var expensesDictionary = OrderedDictionary<String, Double>() // for bar graph
    
    @Published var summaryLabelText: String = ""
    @Published var labelText: String = ""
    
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    } ()
    

    init() {
        fetchExpenses()
    }
    
    func fetchExpenses() {
        expenses = persistenceController.fetchExpenses()
        filterWeek(date: Date())
        // set 3 published properties
    }
    
    func clearData() {
        barExpenses = []
        filteredExpensesForPeriod = []
        filteredExpensesForSelection = []
    }
    
    func filterWeek(date: Date) {
        clearData()
        var weekDays = Calendar.current.shortWeekdaySymbols
        weekDays = weekDays.dropFirst() + [weekDays[0]]
        
        var weekExpenses: OrderedDictionary<String, Double> = [:]
        weekDays.forEach { day in
            weekExpenses[day] = 0.0
        }
        
        // use reduce(into)?
        if let start = calendar.weekBoundary(for: date)?.startOfWeek,
           let end = calendar.weekBoundary(for: date)?.endOfWeek {
            displayedDate = start
            labelText = "\(start.labelText()) - \(end.labelText())"
            for expense in expenses {
                if (start...end).contains(expense.expenseDate) {
                    filteredExpensesForPeriod.append(expense)
//                    let components = calendar.dateComponents([.day], from: expense.expenseDate)
                    let date = expense.expenseDate.shortWeekDay()
                    if weekExpenses.keys.contains(date) {
                        weekExpenses[date] = (weekExpenses[date] ?? 0) + expense.amount
                    }
                }
            }
        }
        
        expensesDictionary = weekExpenses
        filteredExpensesForPeriod.sort {
            $0.expenseDate < $1.expenseDate
        }
       
        var weekSummary: Double = 0.0
        for (day, expense) in weekExpenses {
            self.barExpenses.append(ExpenseBarModel(amount: expense, time: day))
            weekSummary += expense
        }
        
        let maxBar = barExpenses.max { $0.amount < $1.amount }
        maxExpense = Int(maxBar?.amount ?? 200)

        var stringSummary = (currencyFormatter.string(from: NSNumber(floatLiteral: weekSummary)) ?? "")
        summaryLabelText = stringSummary.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
    }
    
    func filterMonth(date: Date) {
        clearData()
        var months = calendar.shortMonthSymbols
        
        var monthExpenses: OrderedDictionary<String, Double> = [:]
        months.forEach { month in
            monthExpenses[month] = 0.0
        }
        
        // use reduce(into)?
        labelText = "\(date.formatted(Date.FormatStyle().month(.wide)))"
            for expense in expenses {
                if calendar.isDate(date, equalTo: expense.expenseDate, toGranularity: .month) {
                    filteredExpensesForPeriod.append(expense)
                    let components = calendar.dateComponents([.month], from: expense.expenseDate)
                    if let date = calendar.date(from: components)?.shortMonth(), monthExpenses.keys.contains(date) {
                        monthExpenses[date] = (monthExpenses[date] ?? 0) + expense.amount
                    }
                }
            }
        
        expensesDictionary = monthExpenses
        filteredExpensesForPeriod.sort {
            $0.expenseDate < $1.expenseDate
        }

        var monthSummary: Double = 0.0
        for (month, expense) in monthExpenses {
            self.barExpenses.append(ExpenseBarModel(amount: expense, time: month))
            monthSummary += expense
        }

        var stringSummary = (currencyFormatter.string(from: NSNumber(floatLiteral: monthSummary)) ?? "")
        summaryLabelText = stringSummary.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
    }
    
    func filterYear() {
        
    }
    
    func calculatePreviousWeek() {
        if let date = displayedDate.previousWeek() {
            filterWeek(date: date)
        }
    }
    
    func calculateNextWeek() {
        if let date = displayedDate.nextWeek() {
            filterWeek(date: date)
        }
    }
    
    func getDaySummary(time: String) -> String {
        guard let amount = expensesDictionary[time] else { return "" }
        return String(amount)
    }
    
    func filterExpenses(for selection: String) {
        filteredExpensesForSelection = []
        for expense in filteredExpensesForPeriod {
            if expense.expenseDate.shortMonth() == selection || expense.expenseDate.shortWeekDay() == selection {
                filteredExpensesForSelection.append(expense)
            }
        }
    }
    
}
