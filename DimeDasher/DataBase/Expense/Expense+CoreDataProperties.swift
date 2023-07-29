//
//  Expense+CoreDataProperties.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//
//

import Foundation
import CoreData


extension Expense {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged fileprivate var expenseType: ExpenseType
    @NSManaged public var expenseDescription: String?
    @NSManaged public var amount: Double
    @NSManaged public var expenseDate: Date
    
    var type: ExpenseType {
        get {
            return ExpenseType(rawValue: expenseType.rawValue) ?? .education
        }
        set {
            self.expenseType = newValue
        }
    }
}

extension Expense : Identifiable {
    
}
