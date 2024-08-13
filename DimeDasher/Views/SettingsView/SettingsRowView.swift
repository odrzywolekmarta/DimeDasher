//
//  SettingsRowView.swift
//  DimeDasher
//
//  Created by Majka on 29/07/2023.
//

import SwiftUI

struct SettingsRowView: View {
    var title: String
    var content: String
    var link: String?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(Constants.Fonts.raleway, size: 17))
                .foregroundColor(Color(Constants.Colors.darkPink))
                .opacity(0.7)
            Spacer()
            
            if let link = URL(string: link ?? "") {
                Link(destination: link) {
                    HStack {
                        Text(content)
                            .font(.custom(Constants.Fonts.ralewayBold, size: 17))
                        Image(systemName: Constants.link)
                            .foregroundColor(Color(Constants.Colors.darkPink))
                    }
                }
                .tint(Color(Constants.Colors.darkPink))
            } else {
                Text(content)
                    .font(.custom(Constants.Fonts.ralewayBold, size: 16))
                    .opacity(0.7)
            }
        } // hstack
        .padding(.vertical, 2)
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(title: "Developer", content: "Marta")
            .previewLayout(.sizeThatFits)

    }
}
