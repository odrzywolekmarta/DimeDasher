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
        
        VStack(spacing: 10) {
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

            }
            .padding()
            .background(Color.clear)

            ScrollView {
                ForEach(viewModel.expenses) { expense in
                    TransactionListItem(expense: expense)
                } // loop
            }
        } // scroll view
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionList()
            .environmentObject(MainViewModel())
    }
}
