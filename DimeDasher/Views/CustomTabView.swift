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
                Image(systemName: "list.bullet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(selectedTab == .main ? Color(Constants.darkPink) : Color(Constants.lightPink))
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
                        .foregroundColor(Color(Constants.lightPink))
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .foregroundColor(Color(Constants.darkPink))
                        
                }
                
            } // button
            .offset(y: -32)
            
            Spacer()
            
            Button {
                selectedTab = .chart
            } label: {
                Image(systemName: "chart.pie")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(selectedTab == .chart ? Color(Constants.darkPink) : Color(Constants.lightPink)).foregroundColor(selectedTab == .main ? Color(Constants.darkPink) : Color(Constants.lightPink))
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
