//
//  AddTransactionView.swift
//  DimeDasher
//
//  Created by Majka on 29/06/2023.
//

import SwiftUI


struct AddTransactionView: View {
    @State private var amount: Double = 0.0
    @State private var transactionDescription: String = ""
    var transactionType: TransactionType
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Add new \(transactionType.rawValue)")
                .font(.custom(Constants.ralewayBold, size: 30))
                .padding()
            
            TextField(value: $amount, format: .number) {
                
            }
            .keyboardType(.decimalPad)
            .padding()
            .font(.custom(Constants.raleway, size: 20))
            .background(
                Color.white
                    .cornerRadius(10))
            .padding()
            
            TextField("Note..", text: $transactionDescription)
                .padding()
                .font(.custom(Constants.raleway, size: 20))
                
                .padding()
        } // vstack
        .background(
            Color(Constants.beige)
        )
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(transactionType: .income)
    }
}
