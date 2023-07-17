//
//  IncomeListItem.swift
//  DimeDasher
//
//  Created by Majka on 05/07/2023.
//

import SwiftUI

struct IncomeListItem: View {
    @EnvironmentObject var viewModel: TransactionsListViewModel
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
                    .font(.custom(Constants.Fonts.raleway, size: 17))
            } // group
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(income.amount.moneyValue())
                    .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                Text(income.incomeDate?.toString() ?? "")
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

struct IncomeListItem_Previews: PreviewProvider {
    static var previews: some View {
        IncomeListItem(income: Income())
            .environmentObject(TransactionsListViewModel())
    }
}
