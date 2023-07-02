//
//  AddTransactionViewModel.swift
//  DimeDasher
//
//  Created by Majka on 29/06/2023.
//

import Foundation
import CoreData

enum TransactionType: StringLiteralType {
    case income
    case expense
}

enum IncomeType: String {
    case work
    case gift
    case crypto
    case financialMarket
}

@MainActor final class AddTransactionViewModel: ObservableObject {
    private let context = PersistenceController.shared
    @Published var expenses: [Expense] = []
    
    init() {
        expenses = context.fetchExpenses()
    }
    
    func saveExpense(type: ExpenseType, amount: Double, description: String) {
        context.saveExpense(type: type, amount: amount, description: description)
    }

}
