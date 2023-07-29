//
//  ExpenseListItem.swift
//  DimeDasher
//
//  Created by Majka on 05/07/2023.
//

import SwiftUI

struct ExpenseListItem: View {
    @EnvironmentObject var viewModel: TransactionsListViewModel
    var expense: ExpenseModel
    
    var body: some View {
        HStack {
            
                Image(systemName: expense.expenseType.imageName)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(width: 40)
                Text(expense.expenseType.rawValue)
                    .font(.custom(Constants.Fonts.raleway, size: 17))
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(expense.amount.moneyValue())
                    .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                Text(expense.expenseDate.toString())
                    .font(.custom(Constants.Fonts.raleway, size: 15))
            } // vstack
        } // hstack
        .padding()
        .background(
            Color.white
                .cornerRadius(15)
        )
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct ExpenseListItem_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListItem(expense: ExpenseModel(expenseType: .books, expenseDescription: "harry potter", amount: 30, expenseDate: Date()))
            .environmentObject(TransactionsListViewModel())
    }
}
