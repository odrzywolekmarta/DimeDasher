//
//  AddTransactionViewModel.swift
//  DimeDasher
//
//  Created by Majka on 29/06/2023.
//

import Foundation
import CoreData

enum TransactionType: StringLiteralType, CaseIterable {
    case income
    case expense
}


@MainActor final class AddTransactionViewModel: ObservableObject {
    private let context = PersistenceController.shared
    @Published var expenses: [ExpenseModel] = []
    @Published var income: [Income] = []
    
    init() {
        expenses = context.fetchExpenses()
        income = context.fetchIncome()
    }
    
    func saveExpense(type: ExpenseType, amount: Double, description: String, date: Date) {
        context.saveExpense(type: type, amount: amount, description: description, date: date)
    }
    
    func saveIncome(type: IncomeType, amount: Double, description: String, date: Date) {
        context.saveIncome(type: type, amount: amount, description: description, date: date)
    }

}
