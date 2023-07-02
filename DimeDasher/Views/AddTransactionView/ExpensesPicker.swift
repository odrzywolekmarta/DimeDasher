//
//  ExpensesPicker.swift
//  DimeDasher
//
//  Created by Majka on 02/07/2023.
//

import SwiftUI

struct ExpensesPicker: View {
    @Binding var expense: ExpenseType
    
    var body: some View {
        Picker("Expense type", selection: $expense) {
            ForEach(ExpenseType.allCases, id: \.self) { expense in
                HStack {
                    Image(systemName: expense.imageName)
                        .resizable()
                        .scaledToFit()
                    Text(expense.rawValue)
                } // hstack
            } // foreach
        } // picker
        .pickerStyle(.wheel)
    }
}

struct ExpensesPicker_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesPicker(expense: .constant(.education))
            .previewLayout(.sizeThatFits)
    }
}
