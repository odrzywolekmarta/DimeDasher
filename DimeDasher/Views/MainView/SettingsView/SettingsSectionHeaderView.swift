//
//  SettingsSectionHeaderView.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import SwiftUI

struct SettingsSectionHeaderView: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(Constants.Fonts.ralewayBold, size: 17))
            Spacer()
            Image(systemName: icon)
                .foregroundColor(Color(Constants.Colors.darkPink))
        } // hstack
    }
}

struct SettingsSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSectionHeaderView(title: "Application", icon: "info.circle")
    }
}
