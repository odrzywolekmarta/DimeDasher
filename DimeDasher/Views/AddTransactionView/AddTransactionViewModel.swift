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
    private let context = PersistenceController.shared.viewContext
    @Published var expenses: [Expense] = []
    
    init() {
        fetchExpenses()
    }
    
    //MARK: - Data Base methods
    func fetchExpenses() {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        do {
            expenses = try context.fetch(request)
            print(expenses[0])
        } catch let error {
            print("Error fetchin expenses data: \(error.localizedDescription)")
        }
    }
    
    func saveExpense(type: ExpenseType, amount: Double, description: String) {
        let expense = Expense(context: context)
        expense.id = UUID()
        expense.amount = amount
        expense.type = type
        expense.expenseDescription = description
        
        do {
            try context.save()
        } catch let error {
            print("Error saving expense: \(error.localizedDescription)")
        }
        
    }

}
