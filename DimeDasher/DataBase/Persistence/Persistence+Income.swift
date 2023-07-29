//
//  Persistence+Income.swift
//  DimeDasher
//
//  Created by Majka on 04/07/2023.
//

import Foundation
import CoreData

extension PersistenceController {
    func fetchIncome() -> [Income] {
        let request = NSFetchRequest<Income>(entityName: "Income")
        
        do {
            let income = try viewContext.fetch(request)
            return income
        } catch let error {
            print("Error fetching income data: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveIncome(type: IncomeType, amount: Double, description: String, date: Date) {
        let income = Income(context: viewContext)
        income.id = UUID()
        income.amount = amount
        income.incomeType = type
        income.incomeDescription = description
        income.incomeDate = date
        
        save()
    }
}
