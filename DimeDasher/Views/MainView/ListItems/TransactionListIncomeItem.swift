//
//  TransactionListIncomeItem.swift
//  DimeDasher
//
//  Created by Majka on 04/07/2023.
//

import SwiftUI

struct TransactionListIncomeItem: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State private var detailsPresented: Bool = false
    var income: IncomeModel
    
    var body: some View {
        HStack {
                Image(systemName: Constants.income)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(width: 40)
                Text(income.incomeType.rawValue)
                    .font(.custom(Constants.Fonts.raleway, size: 17))
            
            Spacer()
            
            VStack(alignment: .center) {
                Text(income.amount.moneyValue())
                    .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                Text(income.incomeDate.toString())
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
            TransactionDetailsView(income: income)
                .presentationDetents([.height(250)])
        }
    }
}

struct TransactionListIncomeItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListIncomeItem(income: IncomeModel.init(incomeType: .gift, incomeDescription: "gift", amount: 200, incomeDate: Date()))
            .background(Color(Constants.Colors.beige))
            .previewLayout(.sizeThatFits)
    }
}
