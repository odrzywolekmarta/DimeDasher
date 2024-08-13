//
//  PieChartView.swift
//  DimeDasher
//
//  Created by Majka on 13/08/2023.
//

import SwiftUI

struct CategoriesPieChartView: View {
    @EnvironmentObject var viewModel: ChartViewModel
    @State private var selectedIndex: Int = -1
    @Binding var chartType: ChartType
    @Binding var timeSelected: TimePeriodType
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    selectedIndex = -1
                    switch timeSelected {
                    case .week:
                        viewModel.calculatePreviousWeek()
                    case .month:
                        viewModel.calculatePreviousMonth()
                    case .year:
                        ()
                    }
                } label: {
                    Image(systemName: Constants.compactLeft)
                        .foregroundColor(.black)
                        .frame(height: 350)
                }
                
                GroupBox {
                    PieChartView(activeIndex: $selectedIndex, title: viewModel.chartTitle, values: Array(viewModel.pieChartData.values), colors: Constants.chartColors, names: Array(viewModel.pieChartData.keys), innerRadiusFraction: 0.5)
                } label: {
                    HStack {
                        VStack {
                            Text(viewModel.chartTitle)
                                .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                            Text("")
                        }
                        
                        Spacer()
                        
                        Button {
                            chartType = .barChart
                            viewModel.undoSelection()
                        } label: {
                            Image(systemName: Constants.barChart)
                                .padding(10)
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(Constants.Colors.beige))
                                    .frame(width: 30, height: 30))
                        }
                    } // hstack
                    Divider()
                } // groupbox
                .groupBoxStyle(WhiteGroupBox())
                .frame(height: 350)
                .padding(.vertical)
              
                Button {
                    selectedIndex = -1
                    switch timeSelected {
                    case .week:
                        viewModel.calculateNextWeek()
                    case .month:
                        viewModel.calculateNextMonth()
                    case .year:
                        ()
                    }
                } label: {
                    Image(systemName: Constants.compactRight)
                        .foregroundColor(.black)
                        .frame(height: 350)
                }

            } // hstack
 
            PieChartLegend(activeIndex: $selectedIndex, colors: Constants.chartColors,
                           names: Array(viewModel.pieChartData.keys),
                           values: Array(viewModel.pieChartData.values).map { value in
                var string = NumberFormatter().currencyFormatter.string(from: NSNumber(floatLiteral: value))
                return string?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: Constants.currency) ?? "") ?? ""
            },
                           percents:  Array(viewModel.pieChartData.values).map { String(format: Constants.percent, $0 * 100 /  Array(viewModel.pieChartData.values).reduce(0, +)) })
            .padding(.horizontal)
        }
    } // vstack
}

struct CategoriesPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesPieChartView(chartType: .constant(.barChart), timeSelected: .constant(.week))
            .environmentObject(ChartViewModel())
    }
}
