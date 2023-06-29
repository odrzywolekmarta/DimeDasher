//
//  NewTransactionView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct NewTransactionView: View {
    @State private var transactionType: TransactionType = .income
    @State private var addViewPresented: Bool = false
    @Binding var newTransactionPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Add new")
                .font(.custom(Constants.ralewayBold, size: 30))
            Button {
                
            } label: {
                Text("Income")
                    .font(.custom(Constants.raleway, size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            } // button
            .tint(Color(Constants.mediumPink))
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button {
                
            } label: {
                Text("Expense")
                    .font(.custom(Constants.raleway, size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            } // button
            .tint(Color(Constants.mediumPink))
            .buttonStyle(.borderedProminent)
            .padding()
        } // vstack
        .overlay(alignment: .topTrailing, content: {
            Button {
                newTransactionPresented.toggle()
            } label: {
                Image(systemName: Constants.dismissButtonImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color(Constants.lightPink))
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
        NewTransactionView(newTransactionPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
