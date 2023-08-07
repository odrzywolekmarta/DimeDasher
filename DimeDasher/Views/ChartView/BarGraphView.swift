//
//  BarGraphView.swift
//  DimeDasher
//
//  Created by Majka on 05/08/2023.
//

import SwiftUI
import Charts

struct BarGraphView: View {
    var data: [ExpenseBarModel]
    
    var body: some View {
        
        GroupBox {
            Chart(data) { expenses in
                BarMark(x: .value("period", expenses.time), y: .value("amount", expenses.amount))
                    .foregroundStyle(Color(Constants.Colors.mediumPink))
                    
            }
        } label: {
            HStack {
                Text("August")
                    .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                Spacer()
            }
            Divider()
        }
        .groupBoxStyle(WhiteGroupBox())
        .padding()
    }
}

struct BarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BarGraphView(data: [ExpenseBarModel(amount: 2000, time: "monday"), ExpenseBarModel(amount: 1000, time: "tuesday"), ExpenseBarModel(amount: 1500, time: "wendesday")])
            .background(Color.black)
    }
}
