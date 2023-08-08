//
//  TransactionDetailsView.swift
//  DimeDasher
//
//  Created by Majka on 02/08/2023.
//

import SwiftUI

struct TransactionDetailsView: View {
    var expense: ExpenseModel?
    var income: IncomeModel?
    
    var body: some View {
        if let expense = expense {
            VStack(spacing: 7) {
                    Image(systemName: expense.expenseType.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                        .opacity(0.6)
                        .foregroundColor(Color(Constants.Colors.mediumPink))
                    VStack {
                        Text(expense.expenseType.rawValue.capitalized)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 28))
                        HStack {
                            Text("Date:")
                            Text(expense.expenseDate.toString())
                        } // hstack
                        .font(.custom(Constants.Fonts.raleway, size: 18))
                    }
                  

                    Text(expense.amount.moneyValue())
                    .font(.custom(Constants.Fonts.ralewayBold, size: 25))
                    .foregroundColor(Color(Constants.Colors.darkPink))
                    
                    Text(expense.expenseDescription)
                        .font(.custom(Constants.Fonts.raleway, size: 17))
                        .opacity(0.7)
            } // vstack
        } else if let income = income {
            VStack(spacing: 7) {
                Image(systemName: Constants.income)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                    .opacity(0.6)
                    .foregroundColor(Color(Constants.Colors.mediumPink))
                VStack {
                    Text(income.incomeType.rawValue.capitalized)
                        .font(.custom(Constants.Fonts.ralewayBold, size: 28))
                    HStack {
                        Text("Date:")
                        Text(income.incomeDate.toString())
                    } // hstack
                    .font(.custom(Constants.Fonts.raleway, size: 18))
                }
                
                
                Text(income.amount.moneyValue())
                    .font(.custom(Constants.Fonts.ralewayBold, size: 25))
                    .foregroundColor(Color(Constants.Colors.darkPink))
                
                Text(income.incomeDescription)
                    .font(.custom(Constants.Fonts.raleway, size: 17))
                    .opacity(0.7)
            }
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(expense: ExpenseModel(expenseType: .books, expenseDescription: "Harry Potter", amount: 45, expenseDate: Date()))
    }
}
