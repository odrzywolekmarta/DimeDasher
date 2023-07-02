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
    @NSManaged public var expenseType: ExpenseType
    @NSManaged public var amount: Double

}

extension Expense : Identifiable {

}
