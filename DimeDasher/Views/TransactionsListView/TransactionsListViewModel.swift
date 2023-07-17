//
//  TransactionsListViewModel.swift
//  DimeDasher
//
//  Created by Majka on 05/07/2023.
//

import Foundation

@MainActor final class TransactionsListViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    @Published var expenses: [Expense] = []
    @Published var income: [Income] = []
    let sideMenuItems: [String: String] = ["Sort": Constants.sort, "Category": Constants.category, "Filter": Constants.filter]
    
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
    
    
}

extension TransactionsListViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
    }
}
