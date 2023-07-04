//
//  Persistence+Expense.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//

import Foundation
import CoreData

extension PersistenceController {
    func fetchExpenses() -> [Expense] {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let expenses = try viewContext.fetch(request)
            return expenses
        } catch let error {
            print("Error fetchin expenses data: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveExpense(type: ExpenseType, amount: Double, description: String, date: Date) {
        let expense = Expense(context: viewContext)
        expense.id = UUID()
        expense.amount = amount
        expense.type = type
        expense.expenseDescription = description
        expense.expenseDate = date
        
        save()
    }

}
