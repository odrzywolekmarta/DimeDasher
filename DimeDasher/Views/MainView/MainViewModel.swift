//
//  MainViewModel.swift
//  DimeDasher
//
//  Created by Majka on 28/06/2023.
//

import Foundation
import UIKit

@MainActor final class MainViewModel: ObservableObject {
    private let persistenceController = PersistenceController.shared
    private let fileManager: LocalFileManager
    @Published var balance: String = ""
    @Published var expensesThisMonth: String = ""
    @Published var incomeThisMonth: String = ""
    @Published var expenses: [ExpenseModel] = []
    @Published var income: [IncomeModel] = []
    @Published var shortExpenses: [ExpenseModel] = []
    @Published var shortIncome: [IncomeModel] = []
    @Published var profilePic: UIImage?
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    } ()
    
    init(fileManager: LocalFileManager) {
        self.fileManager = fileManager
        fetchExpenses()
        fetchIncome()
        calculateBalance()
        profilePic = fileManager.loadImage(imageName: "photo", folderName: "profilePicture")
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

    func calculateBalance() {
        let startingBalance = UserDefaults.standard.double(forKey: "startingBalance")
        
        // total balance
        var totalIncome: Double = 0.0
        var totalExpenses: Double = 0.0
        for expense in expenses {
            totalExpenses += expense.amount
        }
        for income in income {
            totalIncome += income.amount
        }
        let totalBalance = startingBalance + totalIncome - totalExpenses
        var stringBalance = currencyFormatter.string(from: NSNumber(floatLiteral: totalBalance))
        
        // income balance
        let incomeThisMonth = income.filter { income in
            Calendar.current.isDate(Date(), equalTo: income.incomeDate, toGranularity: .month)
        }
        var incomeBalanceThisMonth: Double = 0
        for income in incomeThisMonth {
            incomeBalanceThisMonth += income.amount
        }
        var stringIncome = currencyFormatter.string(from: NSNumber(floatLiteral: incomeBalanceThisMonth))
        
        // expense balance
        let expenseThisMonth = expenses.filter { expense in
            Calendar.current.isDate(Date(), equalTo: expense.expenseDate, toGranularity: .month)
        }
        var expenseBalanceThisMonth: Double = 0
        for expense in expenseThisMonth {
            expenseBalanceThisMonth += expense.amount
        }
        var stringExpense = currencyFormatter.string(from: NSNumber(floatLiteral: expenseBalanceThisMonth))
        
        balance = stringBalance?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "") ?? ""
        self.incomeThisMonth = stringIncome?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "") ?? ""
        self.expensesThisMonth = stringExpense?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "") ?? ""
    }
    
    func getProfilePicture() {
        profilePic = fileManager.loadImage(imageName: "photo", folderName: "profilePicture")
    }

}

extension MainViewModel {
//    convenience init(forPreview: Bool = true) {
//        self.init()
//        username = "John Doe"
//        balance = "10000"
//        let expense = Expense(context: persistenceController.viewContext)
//        expense.id = UUID()
//        expense.amount = 200
//        expense.expenseDescription = "test"
//        expense.type = .books
//        expense.expenseDate = Date()
////        expenses = [expense, expense, expense, expense, expense, expense]
//        let inc = Income(context: persistenceController.viewContext)
//        inc.id = UUID()
//        inc.amount = 1000
//        inc.incomeDate = Date()
//        inc.type = .work
//        inc.incomeDescription = "salary"
//        income = [inc, inc, inc, inc, inc, inc, inc, inc]
//        shortIncome = [inc, inc, inc]
//        shortExpenses = [expense, expense, expense]
//    }
}
