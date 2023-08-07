//
//  ChartView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct ChartView: View {
    @StateObject var viewModel = ChartViewModel()
    @State private var timeSelected: TimePeriodType = .week
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.Fonts.ralewayBold, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.font: UIFont(name: Constants.Fonts.raleway, size: 18) ?? UIFont.systemFont(ofSize: 18)],
            for: .normal)
    }

    var body: some View {
        ZStack {
            Color(Constants.Colors.beige)
                .ignoresSafeArea()
            
            VStack {
                Picker("", selection: $timeSelected) {
                    ForEach(TimePeriodType.allCases, id: \.self) { period in
                        Text(period.rawValue)
                    } // foreach
                } // picker
                .pickerStyle(.segmented)
                .colorMultiply(Color(Constants.Colors.lightPink))
                .cornerRadius(4)
                .padding(.horizontal)
                .onChange(of: timeSelected) { _ in
                    switch timeSelected {
                    case .week:
                        viewModel.filterWeek(date: Date())
                    case .month:
                        viewModel.filterMonth(date: Date())
                    case .year:
                        viewModel.filterYear()
                    }
                }
                
                BarGraphView()
                
                HStack {
                    Text("Transactions")
                        .padding(.horizontal)
                        .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                    Spacer()
                }
                
                List(viewModel.filteredExpensesForSelection.isEmpty ? $viewModel.filteredExpensesForPeriod : $viewModel.filteredExpensesForSelection, id: \.id,
                     editActions: .delete) { $expense in
                    TransactionListExpenseItem(expense: expense)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color(Constants.Colors.beige))
                } // list
                     .listStyle(PlainListStyle())
                     .background(Color(Constants.Colors.beige))
                     .scrollContentBackground(.hidden)
                Spacer()
            } // vstack
        } // zstack
        .environmentObject(viewModel)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
