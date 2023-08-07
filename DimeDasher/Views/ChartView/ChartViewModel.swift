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
    private var expenses = [ExpenseModel]()
    @Published var weekExpenses = [ExpenseBarModel]()
    @Published var montExpenses = [ExpenseBarModel]()
    @Published var yearExpenses = [ExpenseBarModel]()

    init() {
        fetchExpenses()
    }
    
    func fetchExpenses() {
        expenses = persistenceController.fetchExpenses()
        filterWeek(forDay: Date())
        // set 3 published properties
    }
    
    func filterWeek(forDay day: Date) {
        var weekDays = Calendar.current.shortWeekdaySymbols
        weekDays = weekDays.dropFirst() + [weekDays[0]]
        
        var weekExpenses: OrderedDictionary<String, Double> = [:]
        weekDays.forEach { day in
            weekExpenses[day] = 0.0
        }
        
        // use reduce(into)?
        if let start = Calendar.current.weekBoundary(for: day)?.startOfWeek,
           let end = Calendar.current.weekBoundary(for: day)?.endOfWeek {
            for expense in expenses {
                if (start...end).contains(expense.expenseDate) {
                    let components = Calendar.current.dateComponents([.day], from: expense.expenseDate)
                    if let date = Calendar.current.date(from: components)?.shortWeekDay(), weekExpenses.keys.contains(date) {
                        weekExpenses[date] = (weekExpenses[date] ?? 0) + expense.amount
                    }
                }
            }
        }
       
        for (day, expense) in weekExpenses {
            self.weekExpenses.append(ExpenseBarModel(amount: expense, time: day))
        }
    }
    
    func filterMonth() {
        
    }
    
    func filterYear() {
        
    }
    
}
