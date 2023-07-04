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
    @State private var amount: Double?
    @State private var transactionDescription: String = ""
    @State private var expenseType: ExpenseType = .housing
    @State private var incomeType: IncomeType = .work
    @State private var date: Date = Date()
    @State private var saveButtonDisabled: Bool = true
    
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
                    Text("$100..")
                }
                .onChange(of: amount, perform: { newValue in
                    if newValue ?? 0 > 0 {
                        saveButtonDisabled = false
                    }
                })
                .keyboardType(.decimalPad)
                .padding()
                .font(.custom(Constants.raleway, size: 20))
                .background(
                    Color.white
                        .cornerRadius(10))
                .padding()
                
                switch transactionType {
                case .income:
                    IncomePickerView(income: $incomeType)
                case .expense:
                    ExpensesPicker(expense: $expenseType)
                }
                
                TextField("Note..", text: $transactionDescription, axis: .vertical)
                    .padding()
                    .font(.custom(Constants.raleway, size: 20))
                    .padding()

                Button {
                    switch transactionType {
                    case .income:
                        viewModel.saveIncome(type: incomeType, amount: amount ?? 0, description: transactionDescription, date: date)
                    case .expense:
                        viewModel.saveExpense(type: expenseType, amount: amount ?? 0, description: transactionDescription, date: date)
                    }
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .padding()
                .background(
                    Color(saveButtonDisabled ? Constants.lightPink : Constants.mediumPink)
                        .cornerRadius(10)
                )
                .buttonStyle(.borderless)
                .disabled(saveButtonDisabled)
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
