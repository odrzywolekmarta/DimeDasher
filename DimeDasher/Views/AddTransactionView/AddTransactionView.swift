//
//  AddTransactionView.swift
//  DimeDasher
//
//  Created by Majka on 29/06/2023.
//

import SwiftUI


struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = AddTransactionViewModel()
    @State private var amount: Double = 0.0
    @State private var transactionDescription: String = ""
    @State private var expenseType: ExpenseType = .housing
    @State private var date: Date = Date()
    
    var transactionType: TransactionType
    
    var body: some View {
        ZStack {
            Color(Constants.beige)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Add new \(transactionType.rawValue)")
                    .font(.custom(Constants.ralewayBold, size: 30))
                    .padding()
                DatePicker("", selection: $date, displayedComponents: .date)
                .padding()
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "en_UK"))

                TextField(value: $amount, format: .number) {
                    
                }
                .keyboardType(.decimalPad)
                .padding()
                .font(.custom(Constants.raleway, size: 20))
                .background(
                    Color.white
                        .cornerRadius(10))
                .padding()
                
                switch transactionType {
                case .income:
                    ExpensesPicker(expense: $expenseType)
                case .expense:
                    ExpensesPicker(expense: $expenseType)
                }
                
                TextField("Note..", text: $transactionDescription, axis: .vertical)
                    .padding()
                    .font(.custom(Constants.raleway, size: 20))
                    .padding()

                Button {
                    viewModel.saveExpense(type: expenseType, amount: amount, description: transactionDescription)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .padding()
                .background(
                    Color(Constants.mediumPink)
                        .cornerRadius(10)
                )
                .buttonStyle(.borderless)
                .padding()

            } // vstack
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(transactionType: .expense)
    }
}
