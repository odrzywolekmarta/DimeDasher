//
//  ExpenseModel.swift
//  DimeDasher
//
//  Created by Majka on 27/07/2023.
//

import Foundation

struct ExpenseModel: Hashable, Identifiable {
    let id = UUID()
    let expenseType: ExpenseType
    let expenseDescription: String
    let amount: Double
    let expenseDate: Date
}
