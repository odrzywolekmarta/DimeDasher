//
//  NewTransactionView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct NewTransactionView: View {
    @Binding var transactionType: TransactionType
    @Binding var addViewPresented: Bool
    @Binding var newTransactionPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text(Constants.addNew)
                .font(.custom(Constants.Fonts.ralewayBold, size: 30))
            Button {
                transactionType = .income
                addViewPresented.toggle()
                newTransactionPresented.toggle()
            } label: {
                Text(Constants.summaryIncome)
                    .font(.custom(Constants.Fonts.raleway, size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            } // button
            .tint(Color(Constants.Colors.mediumPink))
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                transactionType = .expense
                addViewPresented.toggle()
                newTransactionPresented.toggle()
            } label: {
                Text(Constants.expense)
                    .font(.custom(Constants.Fonts.raleway, size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            } // button
            .tint(Color(Constants.Colors.mediumPink))
            .buttonStyle(.borderedProminent)
            .padding()
        } // vstack
        .overlay(alignment: .topTrailing, content: {
            Button {
                withAnimation {
                    newTransactionPresented.toggle()
                }
            } label: {
                Image(systemName: Constants.dismissButtonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color(Constants.Colors.lightPink))
            }
            
        })
        .padding()
        .background(Color(.white))
        .cornerRadius(30)
        .shadow(radius: 20)
        .sheet(isPresented: $addViewPresented) {
            AddTransactionView(transactionType: transactionType)
        }
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView(transactionType: .constant(.expense), addViewPresented: .constant(false), newTransactionPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
