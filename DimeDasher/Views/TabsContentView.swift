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
    @State private var selectedTab: Tab = .main
    @State private var newTransactionPresented: Bool = false

    var body: some View {
        ZStack {
            VStack {
                switch selectedTab {
                case .main:
                    NavigationView {
                        MainView()
                    }
                case .chart:
                    NavigationView {
                        ChartView()
                    }
                } // switch
                
                CustomTabView(selectedTab: $selectedTab, newTransactionPresented: $newTransactionPresented)
            } // vstack
            .zIndex(0)
            
            if newTransactionPresented {
                NewTransactionView(newTransactionPresented: $newTransactionPresented)
                    .padding()
                    .zIndex(1)
            }
            
        } // zstack
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContentView()
    }
}
