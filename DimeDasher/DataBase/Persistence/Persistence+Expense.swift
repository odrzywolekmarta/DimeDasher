//
//  Persistence+Expense.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//

import Foundation
import CoreData

extension PersistenceController {
    func fetchExpenses() -> [ExpenseModel] {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        var expensesArray: [ExpenseModel] = []
        do {
            let expenses = try viewContext.fetch(request)
            for expense in expenses {
                let exp = ExpenseModel(expenseType: expense.type, expenseDescription: expense.expenseDescription ?? "", amount: expense.amount, expenseDate: expense.expenseDate)
                expensesArray.append(exp)
            }
            return expensesArray
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
