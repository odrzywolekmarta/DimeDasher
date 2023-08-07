//
//  ChartSummaryView.swift
//  DimeDasher
//
//  Created by Majka on 07/08/2023.
//

import SwiftUI

struct ChartSummaryView: View {
    var body: some View {
        GroupBox {
            
        } label: {
            HStack {
                Text("Summary")
                    .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                Spacer()
            }
            Divider()
        }
        .groupBoxStyle(WhiteGroupBox())
    }
}

struct ChartSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ChartSummaryView()
            .background(Color.gray)
    }
}
