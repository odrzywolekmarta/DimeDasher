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
    @Published var expenses: [ExpenseModel] = []
    @Published var income: [IncomeModel] = []
    @Published var shortExpenses: [ExpenseModel] = []
    @Published var shortIncome: [IncomeModel] = []
    
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
        expenses = persistenceController.fetchExpenses().sorted {
            $0.expenseDate > $1.expenseDate
        }
        shortExpenses = Array(expenses.prefix(10))
    }
    
    func fetchIncome() {
        income = persistenceController.fetchIncome().sorted {
                $0.incomeDate > $1.incomeDate
            }
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
}

extension MainViewModel {
    convenience init(forPreview: Bool = true) {
        self.init()
        username = "John Doe"
        balance = "10000"
        let expense = Expense(context: persistenceController.viewContext)
        expense.id = UUID()
        expense.amount = 200
        expense.expenseDescription = "test"
        expense.type = .books
        expense.expenseDate = Date()
//        expenses = [expense, expense, expense, expense, expense, expense]
        let inc = Income(context: persistenceController.viewContext)
        inc.id = UUID()
        inc.amount = 1000
        inc.incomeDate = Date()
        inc.type = .work
        inc.incomeDescription = "salary"
//        income = [inc, inc, inc, inc, inc, inc, inc, inc]
//        shortIncome = [inc, inc, inc]
//        shortExpenses = [expense, expense, expense]
    }
}
