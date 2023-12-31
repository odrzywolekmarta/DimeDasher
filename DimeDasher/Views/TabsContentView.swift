//
//  TabsContentView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

enum Tab {
    case main
    case chart
}

struct TabsContentView: View {
    @StateObject private var mainViewModel = MainViewModel(fileManager: LocalFileManager())
    @StateObject var listViewModel = TransactionsListViewModel()
    @StateObject var chartViewModel = ChartViewModel()
    @State private var selectedTab: Tab = .main
    @State private var newTransactionPresented: Bool = false
    @State private var addViewPresented: Bool = false
    @State private var transactionType: TransactionType = .expense

    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case .main:
                    NavigationView {
                        MainView()
                            .environmentObject(mainViewModel)
                            .environmentObject(listViewModel)
                    }
                case .chart:
                        StatsView()
                        .environmentObject(chartViewModel)
                } // switch
                
                CustomTabView(selectedTab: $selectedTab,
                              newTransactionPresented: $newTransactionPresented)
            } // vstack
            .zIndex(0)
            
            if newTransactionPresented {
                NewTransactionView(transactionType: $transactionType,
                                   addViewPresented: $addViewPresented,
                                   newTransactionPresented: $newTransactionPresented)
                    .padding()
                    .zIndex(1)
            }
        } // zstack
        .onChange(of: selectedTab, perform: { _ in
            switch selectedTab {
            case .main:
                mainViewModel.fetchExpenses()
                mainViewModel.fetchIncome()
                mainViewModel.calculateBalance()
                listViewModel.fetchExpenses()
                listViewModel.fetchIncome()
            case .chart:
                chartViewModel.fetchExpenses()
            }
        })
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $addViewPresented, onDismiss: {
            mainViewModel.fetchExpenses()
            mainViewModel.fetchIncome()
            mainViewModel.calculateBalance()
            listViewModel.fetchExpenses()
            listViewModel.fetchIncome()
            chartViewModel.fetchExpenses()
        }, content: {
            AddTransactionView(transactionType: transactionType)
        })

    }
}

struct TabsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContentView()
    }
}
