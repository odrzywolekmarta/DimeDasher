//
//  TransactionListItem.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct TransactionListItem: View {
    var expense: Expense
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: expense.type.imageName)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(width: 40)
                Text(expense.type.rawValue)
                    .font(.custom(Constants.raleway, size: 17))
            } // group
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(String(expense.amount))
                    .font(.custom(Constants.ralewayBold, size: 17))
                Text("Today")
                    .font(.custom(Constants.raleway, size: 15))
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

struct TransactionListItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListItem(expense: Expense())
            .background(Color(Constants.beige))
            .previewLayout(.sizeThatFits)
    }
}
