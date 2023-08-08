//
//  TransactionListItem.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct TransactionListExpenseItem: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State private var detailsPresented: Bool = false
    var expense: ExpenseModel
    
    var body: some View {
        HStack {
                Image(systemName: expense.expenseType.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .opacity(0.6)
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
        .onTapGesture {
            detailsPresented.toggle()
        }
        .sheet(isPresented: $detailsPresented) {
            TransactionDetailsView(expense: expense)
                .presentationDetents([.height(250)])
        }
    }
}

struct TransactionListExpenseItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListExpenseItem(expense: ExpenseModel(expenseType: .books, expenseDescription: "harry potter", amount: 50, expenseDate: Date()))
            .background(Color(Constants.Colors.beige))
            .previewLayout(.sizeThatFits)
    }
}
