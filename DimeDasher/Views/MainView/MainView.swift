//
//  MainView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Color(Constants.beige)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
            HeaderView()
            SummaryView()
            ShortTransactionList()
                Spacer()
            } // vstack
        } // zstack
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel(forPreview: true))
    }
}
