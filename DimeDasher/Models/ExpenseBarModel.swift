//
//  ExpenseBarModel.swift
//  DimeDasher
//
//  Created by Majka on 05/08/2023.
//

import Foundation

struct ExpenseBarModel: Hashable, Identifiable {
    let id = UUID()
    let amount: Double
    let time: String
}
