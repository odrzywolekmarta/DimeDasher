//
//  TransactionsListView.swift
//  DimeDasher
//
//  Created by Majka on 05/07/2023.
//

import SwiftUI

struct TransactionsListView: View {
    @ObservedObject var viewModel = TransactionsListViewModel()
    @State private var transactionType: TransactionType = .income
    @State private var sideBarVisible: Bool = false
    @State private var filtersVisible: Bool = false

    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.Fonts.ralewayBold, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.Fonts.raleway, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color(Constants.Colors.beige)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("All Transactions")
                        .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                    
                    Spacer()
                  
                } // hstack
                .padding()
                
                Picker("", selection: $transactionType) {
                    ForEach(TransactionType.allCases, id: \.self) { transaction in
                        Text(transaction.rawValue)
                    }
                }
                .font(.custom(Constants.Fonts.raleway, size: 17))
                .pickerStyle(.segmented)
                .colorMultiply(Color(Constants.Colors.lightPink))
                .cornerRadius(4)
                .padding(.horizontal)
                
                Spacer()
                
                switch transactionType {
                case .income:
                    List($viewModel.income, id: \.id,
                         editActions: .delete) { $income in
                        TransactionListIncomeItem(income: income)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .background(Color(Constants.Colors.beige))
                    } // list
                         .listStyle(PlainListStyle())
                         .background(Color(Constants.Colors.beige))
                         .scrollContentBackground(.hidden)
                case .expense:
                    List {
                        ForEach($viewModel.expenses, id: \.id) { $expense in
                            TransactionListExpenseItem(expense: expense)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .background(Color(Constants.Colors.beige))
                        } // foreach
                    } // list
                         .listStyle(PlainListStyle())
                         .background(Color(Constants.Colors.beige))
                         .scrollContentBackground(.hidden)
                }
            } // vstack
        } // ztacks
        .overlay(content: {
                SideMenuView(sideBarVisible: $sideBarVisible)
                    .hidden(!sideBarVisible)
        })
        .environmentObject(viewModel)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(Constants.Colors.darkPink))
                        Text("Back")
                            .font(.custom(Constants.Fonts.ralewayBold, size: 18))
                        .foregroundColor(Color(Constants.Colors.darkPink))
                    }
                }

            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        sideBarVisible.toggle()
                    }
                } label: {
                    Image(systemName: Constants.filter)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .foregroundColor(Color(Constants.Colors.darkPink))
                }
            }
        } // toolbar
    }
}

struct TransactionsListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView()
            .environmentObject(TransactionsListViewModel())
    }
}
