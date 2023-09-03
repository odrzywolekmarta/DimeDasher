//
//  Persistence+Income.swift
//  DimeDasher
//
//  Created by Majka on 04/07/2023.
//

import Foundation
import CoreData

extension PersistenceController {
    func fetchIncome() -> [IncomeModel] {
        let request = NSFetchRequest<Income>(entityName: "Income")
        var incomeArray = [IncomeModel]()
        do {
            let income = try viewContext.fetch(request)
            for inc in income {
                let inc = IncomeModel(incomeType: inc.type, incomeDescription: inc.incomeDescription ?? "", amount: inc.amount, incomeDate: inc.incomeDate)
                incomeArray.append(inc)
            }
            return incomeArray
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
