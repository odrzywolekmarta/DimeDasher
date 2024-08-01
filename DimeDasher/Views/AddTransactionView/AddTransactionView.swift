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
    @State private var doubleAmount: String = ""
    @State private var transactionDescription: String = "" 
    @State private var expenseType: ExpenseType = .housing
    @State private var incomeType: IncomeType = .work
    @State private var date: Date = Date()
    @State private var saveButtonDisabled: Bool = true
    
    var transactionType: TransactionType
    
    var body: some View {
        ZStack {
            Color(Constants.Colors.beige)
                .ignoresSafeArea()
                .onTapGesture {
                    self.endTextEditing()
                }
            VStack(spacing: 0) {
                Text("Add new \(transactionType.rawValue)")
                    .font(.custom(Constants.Fonts.ralewayBold, size: 30))
                    .padding()
                DatePicker("", selection: $date, displayedComponents: .date)
                .padding()
                .labelsHidden()
                .environment(\.locale, Locale(identifier: "en_UK"))

                TextField("", text: $doubleAmount)
                    .onChange(of: doubleAmount) { newValue in
                        if newValue.contains(".") {
                            var splitted = newValue.split(separator: ".")
                            if splitted.count >= 2 {
                                if splitted[1].count > 2 {
                                    splitted[1] = splitted[1].prefix(2)
                                }
                                doubleAmount = "\(splitted[0]).\(splitted[1])"
                            }
                        }
                    }
                    .keyboardType(.decimalPad)
                    .padding()
                    .font(.custom(Constants.Fonts.raleway, size: 20))
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
                
                TextField("Note..", text: $transactionDescription.max(70), axis: .vertical)
                    .padding()
                    .font(.custom(Constants.Fonts.raleway, size: 20))
                    .padding()

                Button {
                    switch transactionType {
                    case .income:
                        viewModel.saveIncome(type: incomeType, amount: Double(doubleAmount) ?? 0, description: transactionDescription, date: date)
                    case .expense:
                        viewModel.saveExpense(type: expenseType, amount: Double(doubleAmount) ?? 0, description: transactionDescription, date: date)
                    }
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .padding()
                .background(
                    Color(self.doubleAmount == "" ? Constants.Colors.lightPink : Constants.Colors.mediumPink)
                        .cornerRadius(10)
                )
                .buttonStyle(.borderless)
                .disabled(self.doubleAmount == "")
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
