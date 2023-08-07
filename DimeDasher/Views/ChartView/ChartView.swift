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
                
                switch timeSelected {
                case .week:
                    BarGraphView(data: viewModel.weekExpenses)
                case .month:
                    BarGraphView(data: viewModel.montExpenses)
                case .year:
                    BarGraphView(data: viewModel.yearExpenses)

                } // switch
                
                
            } // vstack
        } // zstack
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
