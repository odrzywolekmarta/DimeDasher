//
//  ChartView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var viewModel: ChartViewModel
    @State private var selectedDate = Date()
    @State private var detailsPresented: Bool = false
    @State private var chartType: ChartType = .barChart
    
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
                Picker("", selection: $viewModel.displayedTimePeriod) {
                    ForEach(TimePeriodType.allCases, id: \.self) { period in
                        Text(period.rawValue)
                    } // foreach
                } // picker
                .pickerStyle(.segmented)
                .colorMultiply(Color(Constants.Colors.lightPink))
                .cornerRadius(4)
                .padding(.horizontal)
                
                switch chartType {
                case .pieChart:
                    CategoriesPieChartView(chartType: $chartType, timeSelected: $viewModel.displayedTimePeriod)
                        .padding(.horizontal, 5)

                case .barChart:
                    BarChartView(timeSelected: $viewModel.displayedTimePeriod, chartType: $chartType)
                        .padding(.horizontal, 5)
                    
                    HStack {
                        Text("Transactions")
                            .padding(.horizontal)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                        Spacer()
                    }
                    
                    if !viewModel.filteredExpensesForPeriod.isEmpty || !viewModel.filteredExpensesForSelection.isEmpty
                    {
                        List {
                            ForEach(viewModel.filteredExpensesForSelection.isEmpty ? $viewModel.filteredExpensesForPeriod : $viewModel.filteredExpensesForSelection, id: \.id) { $expense in
                                TransactionListExpenseItem(expense: expense)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    .background(Color(Constants.Colors.beige))
                            } // foreach
                        } // list
                             .listStyle(PlainListStyle())
                             .background(Color(Constants.Colors.beige))
                             .scrollContentBackground(.hidden)
                    } else {
                        Text("No expenses added")
                            .font(.custom(Constants.Fonts.raleway, size: 17))
                            .opacity(0.6)
                            .padding()
                    }
                }
                Spacer()
            } // vstack
        } // zstack
        .environmentObject(viewModel)
        .background(Color(Constants.Colors.beige))
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(ChartViewModel())
    }
}
