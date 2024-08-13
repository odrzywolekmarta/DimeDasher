//
//  IncomePickerView.swift
//  DimeDasher
//
//  Created by Majka on 03/07/2023.
//

import SwiftUI

struct IncomePickerView: View {
    @Binding var income: IncomeType
    var body: some View {
        Picker(Constants.incomeType, selection: $income) {
            ForEach(IncomeType.allCases, id: \.self) { income in 
                HStack {
                    Image(systemName: Constants.income)
                        .resizable()
                        .scaledToFit()
                    Text(income.rawValue)
                } // hstack
            } // foreach
        } // picker
        .pickerStyle(.wheel)
    }
}

struct IncomePickerView_Previews: PreviewProvider {
    static var previews: some View {
        IncomePickerView(income: .constant(.work))
    }
}
