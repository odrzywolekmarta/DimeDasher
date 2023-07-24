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
    @Published var expenses: [Expense] = []
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
    
    func sort(_ type: SortType) {
        switch type {
        case .highest:
            expenses.sort {
                $0.amount > $1.amount
            }
            income.sort {
                $0.amount > $1.amount
            }
        case .lowest:
            expenses.sort {
                $0.amount < $1.amount
            }
            income.sort {
                $0.amount < $1.amount
            }
        case .newest:
            expenses.sort {
                $0.expenseDate < $1.expenseDate
            }
            income.sort {
                $0.incomeDate < $1.incomeDate
            }
        case .oldest:
            expenses.sort {
                $0.expenseDate > $1.expenseDate
            }
            income.sort {
                $0.incomeDate > $1.incomeDate
            }
        }
    }
    
    func filterCategories(selectedCategories: [String]) {
        
    }
}

extension TransactionsListViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
    }
}
