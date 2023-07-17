//
//  SideMenuView.swift
//  DimeDasher
//
//  Created by Majka on 17/07/2023.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var viewModel: TransactionsListViewModel
    @Binding var sideBarVisible: Bool
    @Binding var filtersVisible: Bool

    var sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack {
                VStack {
                    ForEach(viewModel.sideMenuItems.keys, id: \.self) { key in
                        VStack {
                            HStack() {
                                Image(systemName: viewModel.sideMenuItems[key] ?? "")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(key)
                                    .font(.custom(Constants.Fonts.ralewayBold, size: 30))
                            } // hstack
                            Divider()
                        } // vstack
                        .onTapGesture {
                            sideBarVisible.toggle()
                        }
                    } // foreach
                    Spacer()
                } // vstack
                .frame(width: sideBarWidth)
                .background(Color(Constants.Colors.lightPink))
                .offset(x: sideBarVisible ? 0 : -sideBarWidth)
                
                Spacer()
            } // hstack
        } // zstack
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(sideBarVisible: .constant(true))
            .environmentObject(TransactionsListViewModel())
    }
}
