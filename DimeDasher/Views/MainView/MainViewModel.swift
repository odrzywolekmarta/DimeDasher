//
//  MainViewModel.swift
//  DimeDasher
//
//  Created by Majka on 28/06/2023.
//

import Foundation

@MainActor final class MainViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    @Published var username: String = ""
    @Published var balance: String = ""
    @Published var expenses: [Expense] = []
    @Published var income: [Income] = []
    @Published var shortExpenses: [Expense] = []
    @Published var shortIncome: [Income] = []
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    } ()
    
    init() {
        getUserDataFromDefaults()
        calculateBalance()
        fetchExpenses()
        fetchIncome()
    }
    
    func fetchExpenses() {
        expenses = persistenceController.fetchExpenses()
        shortExpenses = Array(expenses.prefix(10))
    }
    
    func fetchIncome() {
        income = persistenceController.fetchIncome()
        shortIncome = Array(income.prefix(10))
    }
    
    func getUserDataFromDefaults() {
        username = UserDefaults.standard.string(forKey: "username") ?? ""
    }
    
    func calculateBalance() {
        var startingBalance = currencyFormatter.string(from: NSNumber(floatLiteral: UserDefaults.standard.double(forKey: "startingBalance")))
//        let calculatedBalance = ""
        balance = startingBalance?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "") ?? ""
    }
    
    func moneyValue(amount: Double) -> String {
        var amountString = String(amount.stringWithTwoDecimal())
        return amountString.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "")
    }
}

extension MainViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
        username = "John Doe"
        balance = "10000"
    }
}
