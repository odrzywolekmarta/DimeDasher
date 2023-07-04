//
//  TransactionList.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("Transactions")
                    .font(.custom(Constants.ralewayBold, size: 20))
                Spacer()
                Button {
                    
                } label: {
                    Text("See all")
                        .font(.custom(Constants.raleway, size: 17))
                        .foregroundColor(Color(Constants.darkPink))
                }
            } // hstack
            .padding()
            .background(Color.clear)
            
            List($viewModel.expenses, id: \.id, editActions: .delete) { $expense in
//                ForEach(viewModel.expenses) { expense in
                    TransactionListItem(expense: expense)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color(Constants.beige))
//                } // loop
            } // list
            .listStyle(PlainListStyle())
            .background(Color(Constants.beige))
            .scrollContentBackground(.hidden)
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
            .environmentObject(MainViewModel())
    }
}
