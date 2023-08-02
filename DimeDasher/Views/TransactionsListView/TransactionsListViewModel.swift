//
//  TransactionsListViewModel.swift
//  DimeDasher
//
//  Created by Majka on 05/07/2023.
//

import Foundation
import Collections

enum FilterType: String, CaseIterable {
    case sort
    case categories
    case dates
}
enum SortType: String, CaseIterable {
    case newest
    case oldest
    case highest
    case lowest
}

enum DateSelection: String, CaseIterable {
    case range
    case multipleDates
    
    init?(rawValue: String) {
        switch rawValue {
        case "Range": self = .range
        case "Multiple Dates": self = .multipleDates
        default: self = .range
        }
    }
    
    public typealias RawValue = String
    
    var rawValue: RawValue {
        switch self {
        case .range:
            return "Range"
        case .multipleDates:
            return "Multiple Dates"
        }
    }
}

@MainActor final class TransactionsListViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    @Published var expenses: [ExpenseModel] = []
    @Published var filteredExpenses: [ExpenseModel] = []
    @Published var income: [IncomeModel] = []
    @Published var filteredIncome: [IncomeModel] = []
    
    init() {
        fetchExpenses()
        fetchIncome()
        print("view model init")
    }
    
    func fetchExpenses() {
        expenses = persistenceController.fetchExpenses().sorted {
            $0.expenseDate > $1.expenseDate
        }
    }
    
    func fetchIncome() {
        income = persistenceController.fetchIncome().sorted {
            $0.incomeDate > $1.incomeDate
        }
    }
    
    func cleanFilters() {
        filteredIncome = []
        filteredExpenses = []
    }
    
    func applyFilers(fromDate: Date? = nil, toDate: Date? = nil, dates: Set<DateComponents>? = nil, categories: [String], sort: SortType) {
        var filteredExpenses = [ExpenseModel]()
        var filteredIncome = [IncomeModel]()

        // filter multiple dates selection
        if let dates = dates {
            let datesArray = dates.dateArray()
            for expense in expenses {
                for date in datesArray {
                    if Calendar.current.isDate(date, equalTo: expense.expenseDate, toGranularity: .day) {
                        filteredExpenses.append(expense)
                    }
                }
            }
            
            for income in income {
                for date in datesArray {
                    if Calendar.current.isDate(date, equalTo: income.incomeDate, toGranularity: .day) {
                        filteredIncome.append(income)
                    }
                }
            }
        }
        
        // filter section
        if let from = fromDate,
           let to = toDate {
            for expense in expenses {
                if (from...to).contains(expense.expenseDate) {
                    filteredExpenses.append(expense)
                }
            }

            for income in income {
                if (from...to).contains(income.incomeDate) {
                    filteredIncome.append(income)
                }
            }
        } else if let from = fromDate {
            for expense in expenses {
                if (from...).contains(expense.expenseDate) {
                    filteredExpenses.append(expense)
                }
            }
            for income in income {
                if (from...).contains(income.incomeDate) {
                    filteredIncome.append(income)
                }
            }
        } else if let to = toDate {
            for expense in expenses {
                if (...to).contains(expense.expenseDate) {
                    filteredExpenses.append(expense)
                }
            }
            for income in income {
                if (...to).contains(income.incomeDate) {
                    filteredIncome.append(income)
                }
            }
        }
        
        if filteredExpenses.isEmpty {
            filteredExpenses = expenses
        }
        
        if filteredIncome.isEmpty {
            filteredIncome = income
        }
        
        if categories.count > 0 {
            filteredExpenses = filteredExpenses.filter { expense in
                categories.contains(expense.expenseType.rawValue)
            }
            filteredIncome = filteredIncome.filter { income in
                categories.contains(income.incomeType.rawValue)
            }
        }
        
        switch sort {
        case .highest:
            filteredExpenses.sort {
                $0.amount > $1.amount
            }
            filteredIncome.sort {
                $0.amount > $1.amount
            }
        case .lowest:
            filteredExpenses.sort {
                $0.amount < $1.amount
            }
            filteredIncome.sort {
                $0.amount < $1.amount
            }
        case .newest:
            filteredExpenses.sort {
                $0.expenseDate > $1.expenseDate
            }
            filteredIncome.sort {
                $0.incomeDate > $1.incomeDate
            }
        case .oldest:
            filteredExpenses.sort {
                $0.expenseDate < $1.expenseDate
            }
            filteredIncome.sort {
                $0.incomeDate < $1.incomeDate
            }
        }
        self.filteredExpenses = filteredExpenses
        self.filteredIncome = filteredIncome
    }
}

extension TransactionsListViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
    }
}
