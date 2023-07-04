//
//  TransactionListIncomeItem.swift
//  DimeDasher
//
//  Created by Majka on 04/07/2023.
//

import SwiftUI

struct TransactionListIncomeItem: View {
    @EnvironmentObject var viewModel: MainViewModel
    var income: Income
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: Constants.income)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(width: 40)
                Text(income.type.rawValue)
                    .font(.custom(Constants.raleway, size: 17))
            } // group
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(viewModel.moneyValue(amount: income.amount))
                    .font(.custom(Constants.ralewayBold, size: 17))
                Text(income.incomeDate?.toString() ?? "")
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

struct TransactionListIncomeItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListIncomeItem(income: Income())
            .background(Color(Constants.beige))
            .previewLayout(.sizeThatFits)
    }
}
