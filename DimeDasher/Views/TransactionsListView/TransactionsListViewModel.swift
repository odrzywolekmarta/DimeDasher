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
    @Published var income: [Income] = []
    
    init() {
        fetchExpenses()
        fetchIncome()
    }
    
    func fetchExpenses() {
        expenses = persistenceController.fetchExpenses()
    }
    
    func fetchIncome() {
        income = persistenceController.fetchIncome()
    }
    
    func applyFilers(fromDate: Date? = nil, toDate: Date? = nil, dates: Set<DateComponents>? = nil, categories: [String], sort: SortType) {
        print(expenses)
        if let dates = dates {
            expenses = expenses.filter { expense in
                let components = Calendar.current.dateComponents([.day, .month, .year], from: expense.expenseDate)
                return dates.contains(components)
            }
        }
        
        if let from = fromDate,
           let to = toDate {
            expenses = expenses.filter { expense in
                (from...to).contains(expense.expenseDate)
            }
        } else if let from = fromDate {
            expenses = expenses.filter { expense in
                (from...).contains(expense.expenseDate)
            }
        } else if let to = toDate {
            expenses = expenses.filter { expense in
                (...to).contains(expense.expenseDate)
            }
        }
        
        if categories.count > 0 {
            expenses = expenses.filter { expense in
                categories.contains(expense.expenseType.rawValue)
            }
        }
        
        switch sort {
        case .highest:
            expenses = expenses.sorted {
                $0.amount > $1.amount
            }
            income.sort {
                $0.amount > $1.amount
            }
        case .lowest:
            expenses = expenses.sorted {
                $0.amount < $1.amount
            }
            income.sort {
                $0.amount < $1.amount
            }
        case .newest:
            expenses = expenses.sorted {
                $0.expenseDate > $1.expenseDate
            }
            income.sort {
                $0.incomeDate > $1.incomeDate
            }
        case .oldest:
            expenses = expenses.sorted {
                $0.expenseDate < $1.expenseDate
            }
            income.sort {
                $0.incomeDate < $1.incomeDate
            }
        }
        print(expenses)
    }
}

extension TransactionsListViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
    }
}
