//
//  TransactionList.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct ShortTransactionList: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State private var transactionType: TransactionType = .income
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.ralewayBold, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.raleway, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Transactions")
                    .font(.custom(Constants.ralewayBold, size: 20))
                Spacer()
                NavigationLink {
                    TransactionsListView()
                } label: {
                    Text("See all")
                        .font(.custom(Constants.raleway, size: 17))
                        .foregroundColor(Color(Constants.darkPink))
                }
            } // hstack
            .padding()
            .background(Color.clear)
            
            Picker("", selection: $transactionType) {
                ForEach(TransactionType.allCases, id: \.self) { transaction in
                    Text(transaction.rawValue)
                }
            }
            .font(.custom(Constants.raleway, size: 17))
            .pickerStyle(.segmented)
            .colorMultiply(Color(Constants.lightPink))
            .cornerRadius(4)
            .padding(.horizontal )
            

            switch transactionType {
            case .income:
                List($viewModel.shortIncome, id: \.id,
                     editActions: .delete) { $income in
                    TransactionListIncomeItem(income: income)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color(Constants.beige))
                } // list
                .listStyle(PlainListStyle())
                .background(Color(Constants.beige))
                .scrollContentBackground(.hidden)
            case .expense:
                List($viewModel.shortExpenses, id: \.self,
                     editActions: .delete) { $expense in
                    TransactionListExpenseItem(expense: expense)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color(Constants.beige))
                } // list
                .listStyle(PlainListStyle())
                .background(Color(Constants.beige))
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        ShortTransactionList()
            .environmentObject(MainViewModel(forPreview: true))
    }
}
