//
//  TransactionList.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct ShortTransactionList: View {
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var listViewModel: TransactionsListViewModel
    @State private var transactionType: TransactionType = .income
    @State private var detailsPresented: Bool = false
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.Fonts.ralewayBold, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.Fonts.raleway, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .normal)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(Constants.transactionsTitle)
                    .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                Spacer()
                NavigationLink {
                    TransactionsListView()
                        .environmentObject(listViewModel)
                } label: {
                    Text(Constants.viewAll)
                        .font(.custom(Constants.Fonts.raleway, size: 17))
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
            } // hstack
            .padding()
            .background(Color.clear)
            
            Picker("", selection: $transactionType) {
                ForEach(TransactionType.allCases, id: \.self) { transaction in
                    Text(transaction.rawValue)
                }
            }
            .font(.custom(Constants.Fonts.raleway, size: 17))
            .pickerStyle(.segmented)
            .colorMultiply(Color(Constants.Colors.lightPink))
            .cornerRadius(4)
            .padding(.horizontal )
            
            
            switch transactionType {
            case .income:
                if viewModel.shortIncome.isEmpty {
                    Text(Constants.noIncome)
                        .font(.custom(Constants.Fonts.raleway, size: 17))
                        .opacity(0.6)
                        .padding()
                } else {
                    List($viewModel.shortIncome, id: \.id,
                         editActions: .delete) { $income in
                        TransactionListIncomeItem(income: income)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .background(Color(Constants.Colors.beige))
                    } // list
                         .listStyle(PlainListStyle())
                         .background(Color(Constants.Colors.beige))
                         .scrollContentBackground(.hidden)
                }
            case .expense:
                if viewModel.shortExpenses.isEmpty {
                    Text(Constants.noExpenses)
                        .font(.custom(Constants.Fonts.raleway, size: 17))
                        .opacity(0.6)
                        .padding()
                } else {
                    List($viewModel.shortExpenses, id: \.id,
                         editActions: .delete) { $expense in
                        TransactionListExpenseItem( expense: expense)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .background(Color(Constants.Colors.beige))
                    } // list
                         .listStyle(PlainListStyle())
                         .background(Color(Constants.Colors.beige))
                         .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        ShortTransactionList()
            .environmentObject(MainViewModel(fileManager: LocalFileManager()))
            .environmentObject(TransactionsListViewModel())
    }
}
