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
    var body: some View {
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

            }
            
            CustomTabView(selectedTab: $selectedTab)
        } // vstack
    }
}

struct TabsContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabsContentView()
    }
}
