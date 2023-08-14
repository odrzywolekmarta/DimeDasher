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

enum ChartType {
    case pieChart
    case barChart
}

@MainActor final class ChartViewModel: ObservableObject {
    @Published var filteredExpensesForPeriod = [ExpenseModel]() // for transactions list
    @Published var filteredExpensesForSelection = [ExpenseModel]() // for transactions list when bar selected on chart
    @Published var barExpenses = [ExpenseBarModel]() // for bar graph
    @Published var maxExpense: Int = 0 // for bar graph
    @Published var expensesDictionary = OrderedDictionary<String, Double>() // for bar graph
    @Published var summaryLabelText: String = ""
    @Published var chartTitle: String = ""
    @Published var pieChartData = [String: Double]()
    
    private let persistenceController = PersistenceController.shared
    private var expenses = [ExpenseModel]() // all expenses (fetch only one year?)
    private var generalChartTitle = ""
    private var generalChartSummary = ""
    var displayedDate: Date = Date()
    var displayedTimePeriod: TimePeriodType = .week
    
    private var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }()
    
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    }()

    init() {
        fetchExpenses()
        filterCategories()
    }
    
    func fetchExpenses() {
        expenses = persistenceController.fetchExpenses()
        filterWeek(date: displayedDate)
        // set 3 published properties
    }
    
    func clearData() {
        barExpenses = []
        filteredExpensesForPeriod = []
        filteredExpensesForSelection = []
    }
    
    //MARK: - Filter Data
    func filterWeek(date: Date) {
        clearData()
        var weekDays = Calendar.current.shortWeekdaySymbols
        weekDays = weekDays.dropFirst() + [weekDays[0]]
        
        var weekExpenses: OrderedDictionary<String, Double> = [:]
        weekDays.forEach { day in
            weekExpenses[day] = 0.0
        }
        
        if let start = calendar.weekBoundary(for: date)?.startOfWeek,
           let end = calendar.weekBoundary(for: date)?.endOfWeek {
            displayedDate = start
            chartTitle = "\(start.labelText()) - \(end.labelText())"
            generalChartTitle = chartTitle
            for expense in expenses {
                if (start...end).contains(expense.expenseDate) {
                    filteredExpensesForPeriod.append(expense)
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
        generalChartSummary = summaryLabelText
    }
    
    func filterYear(date: Date) {
        clearData()
        let months = calendar.shortStandaloneMonthSymbols
        
        var monthExpenses: OrderedDictionary<String, Double> = [:]
        months.forEach { month in
            monthExpenses[month] = 0.0
        }
        
        chartTitle = "\(date.year())"
        generalChartTitle = chartTitle

            for expense in expenses {
                if calendar.isDate(date, equalTo: expense.expenseDate, toGranularity: .year) {
                    filteredExpensesForPeriod.append(expense)
                    let date = expense.expenseDate.shortMonth()
                    if monthExpenses.keys.contains(date) {
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
        
        let maxBar = barExpenses.max { $0.amount < $1.amount }
        maxExpense = Int(maxBar?.amount ?? 200)

        var stringSummary = (currencyFormatter.string(from: NSNumber(floatLiteral: monthSummary)) ?? "")
        summaryLabelText = stringSummary.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
        generalChartSummary = summaryLabelText
    }
    
    func filterMonth(date: Date) {
        clearData()
        let monthDays = date.getDaysInMonth()
        
        var dayExpenses: OrderedDictionary<String, Double> = [:]
        for day in 1...monthDays {
            dayExpenses[String(day)] = 0.0
        }
        
        displayedDate = date

        chartTitle = "\(date.formatted(Date.FormatStyle().month(.wide)))"
        generalChartTitle = chartTitle

            for expense in expenses {
                if calendar.isDate(date, equalTo: expense.expenseDate, toGranularity: .month) {
                    filteredExpensesForPeriod.append(expense)
                    let date = String(expense.expenseDate.get(.day))
                    if dayExpenses.keys.contains(date) {
                        dayExpenses[date] = (dayExpenses[date] ?? 0) + expense.amount
                    }
                }
            }
        
        expensesDictionary = dayExpenses
        filteredExpensesForPeriod.sort {
            $0.expenseDate < $1.expenseDate
        }
        
        var monthSummary: Double = 0.0
        for (day, expense) in dayExpenses {
            self.barExpenses.append(ExpenseBarModel(amount: expense, time: day))
            monthSummary += expense
        }
        
        let maxBar = barExpenses.max { $0.amount < $1.amount }
        maxExpense = Int(maxBar?.amount ?? 200)
        
        var stringSummary = (currencyFormatter.string(from: NSNumber(floatLiteral: monthSummary)) ?? "")
        summaryLabelText = stringSummary.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
        generalChartSummary = summaryLabelText
    }
    
    func filterCategories() {
        var categories = [String: Double]()
        
        ExpenseType.allCases.forEach { type in
            categories[type.rawValue] = 0.0
        }

        for expense in expenses {
            var category = categories[expense.expenseType.rawValue] ?? 0
            switch displayedTimePeriod {
                case .week:
                if let start = calendar.weekBoundary(for: displayedDate)?.startOfWeek,
                   let end = calendar.weekBoundary(for: displayedDate)?.endOfWeek {
                    if (start...end).contains(expense.expenseDate) {
                        categories[expense.expenseType.rawValue]! += expense.amount
                    }
                }
                
                case .month:
                    if calendar.isDate(displayedDate, equalTo: expense.expenseDate, toGranularity: .month) {
                        category += expense.amount
                    }
                case .year:
                    if calendar.isDate(displayedDate, equalTo: expense.expenseDate, toGranularity: .year) {
                        category += expense.amount
                    }
                }
        }
        
        for (key, value) in categories {
            if value == 0.0 {
                categories.removeValue(forKey: key)
            }
        }
        
        pieChartData = categories
    }
    
    //MARK: - Calculate Date Change
        // TODO: w jedną funkcję to włożyć wszystko
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
    
    func calculatePreviousMonth() {
        if let date = displayedDate.previousMonth() {
         filterMonth(date: date)
        }
    }
    
    func calculateNextMonth() {
        if let date = displayedDate.nextMonth() {
         filterMonth(date: date)
        }
    }
    
    //MARK: - Selection Handling
    func getSummary(for time: String, timeSelected: TimePeriodType) {
        guard let amount = expensesDictionary[time] else { return }
        let selected = filteredExpensesForSelection.first { expense in
            expense.expenseDate.shortWeekDay() == time || expense.expenseDate.shortMonth() == time || expense.expenseDate.day() == time
        }
        
        switch timeSelected {
        case .week:
            chartTitle = selected?.expenseDate.labelText() ?? ""
        case .month:
            chartTitle = selected?.expenseDate.labelText() ?? ""
        case .year:
            chartTitle = selected?.expenseDate.formatted(Date.FormatStyle().month(.wide)) ?? ""
        }
        
        summaryLabelText = String(amount)
    }

    func filterExpenses(for selection: String) {
        filteredExpensesForSelection = []
        for expense in filteredExpensesForPeriod {
            if expense.expenseDate.shortMonth() == selection || expense.expenseDate.shortWeekDay() == selection || expense.expenseDate.day() == selection {
                filteredExpensesForSelection.append(expense)
            }
        }
    }
    
    func undoSelection() {
        filteredExpensesForSelection.removeAll()
        summaryLabelText = generalChartSummary
        chartTitle = generalChartTitle
    }
}
