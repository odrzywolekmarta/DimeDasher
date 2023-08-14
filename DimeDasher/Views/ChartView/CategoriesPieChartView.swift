//
//  PieChartView.swift
//  DimeDasher
//
//  Created by Majka on 13/08/2023.
//

import SwiftUI

struct CategoriesPieChartView: View {
    @EnvironmentObject var viewModel: ChartViewModel
    
    var body: some View {
        VStack {
            HStack {
                PieChartView(values: Array(viewModel.pieChartData.values), colors: Constants.chartColors, names: Array(viewModel.pieChartData.keys), innerRadiusFraction: 0.6, title: viewModel.chartTitle)
                    .padding()
                Button {
                    
                } label: {
                    
                }

            }
        } // vstack
        
    }
}

struct CategoriesPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesPieChartView()
            .environmentObject(ChartViewModel())
    }
}
