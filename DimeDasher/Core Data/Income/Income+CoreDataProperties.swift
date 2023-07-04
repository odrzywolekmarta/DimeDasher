//
//  Income+CoreDataProperties.swift
//  DimeDasher
//
//  Created by Majka on 04/07/2023.
//
//

import Foundation
import CoreData


extension Income {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Double
    @NSManaged public var incomeDate: Date?
    @NSManaged public var incomeDescription: String?
    @NSManaged public var incomeType: IncomeType
    
    var type: IncomeType {
        get {
            return IncomeType(rawValue: incomeType.rawValue) ?? .work
        }
        set {
            self.incomeType = newValue
        }
    }

}

extension Income : Identifiable {

}
