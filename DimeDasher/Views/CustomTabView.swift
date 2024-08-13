//
//  CustomTabView.swift
//  DimeDasher
//
//  Created by Majka on 27/06/2023.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    @Binding var newTransactionPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                selectedTab = .main
            } label: {
                Image(systemName: Constants.list)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(selectedTab == .main ? Color(Constants.Colors.darkPink) : Color(Constants.Colors.lightPink))
            } // button

            Spacer()
            
            Button {
                withAnimation {
                    newTransactionPresented.toggle()
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(Color(Constants.Colors.lightPink))
                    Image(systemName: Constants.add)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .foregroundColor(Color(Constants.Colors.darkPink))
                        
                }
                
            } // button
            .offset(y: -32)
            
            Spacer()
            
            Button {
                selectedTab = .chart
            } label: {
                Image(systemName: Constants.pieChart)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(selectedTab == .chart ? Color(Constants.Colors.darkPink) : Color(Constants.Colors.lightPink)).foregroundColor(selectedTab == .main ? Color(Constants.Colors.darkPink) : Color(Constants.Colors.lightPink))
            }
            
            Spacer()
        } // hstack
        
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selectedTab: .constant(.main), newTransactionPresented: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
