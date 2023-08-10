//
//  BarGraphView.swift
//  DimeDasher
//
//  Created by Majka on 05/08/2023.
//

import SwiftUI
import Charts
import Collections

struct BarGraphView: View {
    @EnvironmentObject var viewModel: ChartViewModel
    @State private var select = ""
    @Binding var timeSelected: TimePeriodType

    func animateBars() {
        for (index, _) in viewModel.barExpenses.enumerated() {
            withAnimation(.easeInOut(duration: 0.6)) {
                viewModel.barExpenses[index].animate = true
            }
        }
    }
    
    func doSelection(at location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) {
        let xPos = location.x - geometry[proxy.plotAreaFrame].origin.x
        guard let xbar: String = proxy.value(atX: xPos) else { return }
        if select == xbar {
            select = ""
            viewModel.filteredExpensesForSelection.removeAll()
        } else {
            select = xbar
            viewModel.filterExpenses(for: select)
        }
    }
    
    func shouldDisplayButtons() -> Bool {
        if timeSelected == .year && viewModel.filteredExpensesForPeriod.isEmpty {
            return false
        } else {
            return true
        }
    }
   
    var body: some View {
        HStack {
            if shouldDisplayButtons() {
                Button {
                    select = ""
                    switch timeSelected {
                    case .week:
                        viewModel.calculatePreviousWeek()
                    case .month:
                        viewModel.calculatePreviousMonth()
                    case .year:
                        ()
                    }
                } label: {
                    Image(systemName: "chevron.compact.left")
                        .foregroundColor(.black)
                        .frame(height: 350)
                }
            }
               
            

            GroupBox {
                Chart(viewModel.barExpenses) { expense in
                    BarMark(x: .value("period", expense.time),
                            y: .value("amount", expense.animate ? expense.amount : 0))
                        .foregroundStyle(select == expense.time ? Color(Constants.Colors.darkPink) : Color(Constants.Colors.lightPink))
                        .annotation(position: .top, alignment: .center, spacing: 5) {
                            if select == expense.time {
                                Text(viewModel.getDaySummary(time: expense.time))
                                    .padding(2)
                                    .font(.custom(Constants.Fonts.raleway, size: 12))
                                    .background(
                                        Color(Constants.Colors.beige)
                                        .cornerRadius(2))
                            }
                        }
                } // chart
                .chartYScale(domain: (0...viewModel.maxExpense + 20))
                .onChange(of: viewModel.barExpenses, perform: { _ in
                    animateBars()
                })
                .onAppear {
                   animateBars()
                }
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        ZStack(alignment: .top) {
                            Rectangle().fill(.clear).contentShape(Rectangle())
                                .onTapGesture { location in
                                    doSelection(at: location, proxy: proxy, geometry: geometry)
                                }
                        }
                    }
                }
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.labelText)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 20))
                        Text(String(viewModel.summaryLabelText))
                            .font(.custom(Constants.Fonts.raleway, size: 15))
                            .opacity(0.7)
                    }
                    Spacer()
                }
                Divider()
            } // groupbox
            .groupBoxStyle(WhiteGroupBox())
            .frame(height: 350)
            .padding(.vertical)
            if shouldDisplayButtons() {
                Button {
                    select = ""
                    switch timeSelected {
                    case .week:
                        viewModel.calculateNextWeek()
                    case .month:
                        viewModel.calculateNextMonth()
                    case .year:
                        ()
                    }
                } label: {
                    Image(systemName: "chevron.compact.right")
                        .foregroundColor(.black)
                        .frame(height: 350)

                }

            }
        } // hstack
        .padding(.horizontal, shouldDisplayButtons() ? 0 : 15)
    }
}

struct BarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BarGraphView(timeSelected: .constant(.month))
            .background(Color.black)
            .environmentObject(ChartViewModel())
    }
}
