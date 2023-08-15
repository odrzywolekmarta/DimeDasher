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
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.compact.left")
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
                        } label: {
                            Image(systemName: "chart.bar")
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
                    
                } label: {
                    Image(systemName: "chevron.compact.right")
                        .foregroundColor(.black)
                        .frame(height: 350)
                }

            } // hstack
 
            PieChartLegend(activeIndex: $selectedIndex, colors: Constants.chartColors,
                           names: Array(viewModel.pieChartData.keys),
                           values: Array(viewModel.pieChartData.values).map { value in
                var string = NumberFormatter().currencyFormatter.string(from: NSNumber(floatLiteral: value))
                return string?.stringWithCurrencySymbol(currency: UserDefaults.standard.string(forKey: "currency") ?? "") ?? ""
            },
                           percents:  Array(viewModel.pieChartData.values).map { String(format: "%.0f%%", $0 * 100 /  Array(viewModel.pieChartData.values).reduce(0, +)) })
            .padding(.horizontal)
        }
    } // vstack
}

struct CategoriesPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesPieChartView(chartType: .constant(.barChart))
            .environmentObject(ChartViewModel())
    }
}
