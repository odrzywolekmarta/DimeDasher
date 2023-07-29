//
//  IncomeModel.swift
//  DimeDasher
//
//  Created by Majka on 30/07/2023.
//

import Foundation

struct IncomeModel: Hashable, Identifiable {
    let id = UUID()
    let incomeType: IncomeType
    let incomeDescription: String
    let amount: Double
    let incomeDate: Date
}
