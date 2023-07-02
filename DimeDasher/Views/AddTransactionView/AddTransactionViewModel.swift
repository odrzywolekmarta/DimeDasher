//
//  AddTransactionViewModel.swift
//  DimeDasher
//
//  Created by Majka on 29/06/2023.
//

import Foundation

enum TransactionType: StringLiteralType {
    case income
    case expense
}

enum IncomeType: String {
    case work
    case gift
    case crypto
    case financialMarket
}



@MainActor final class AddTransactionViewModel: ObservableObject {
    
}
