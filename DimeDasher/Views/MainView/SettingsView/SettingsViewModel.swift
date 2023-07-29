//
//  SettingsViewModel.swift
//  DimeDasher
//
//  Created by Majka on 30/07/2023.
//

import Foundation
import CoreData

@MainActor final class SettingsViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared

    func clearData() {
        let expenseRequest = NSFetchRequest<Expense>(entityName: "Expense")
            do {
                let expenses = try persistenceController.viewContext.fetch(expenseRequest)
                for expense in expenses {
                    persistenceController.viewContext.delete(expense)
                }
            } catch {
                print("Error deleting expenses from data base: \(error)")
            }
        
        let incomeRequest = NSFetchRequest<Income>(entityName: "Income")
        do {
            let income = try persistenceController.viewContext.fetch(incomeRequest)
            for inc in income {
                persistenceController.viewContext.delete(inc)
            }
        } catch {
            print("Error deleting income from data base: \(error)")
        }
        
        do {
            try persistenceController.viewContext.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
}
